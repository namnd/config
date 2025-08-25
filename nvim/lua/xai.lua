-- Forked of https://github.com/wolffiex/shellbot/blob/main/chatbot.lua
---@diagnostic disable: duplicate-set-field

local json = require("json")

M = {}

local thread_id = ""
local is_receiving = false -- a flag to make sure same request not being submitted more than once
local roles = {
	user = "🧑 " .. os.getenv("USER"),
	assistant = "🤖 xAI",
}
local buffer_sync_cursor = {}

local split = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local execute_command = function(command)
	local result = {}
	local handle = io.popen(command, "r")
	if handle then
		result.output = handle:read("*a")
		local success, _, exit_code = handle:close()
		result.success = success
		result.exit_code = exit_code or nil
	else
		result.error = "Failed to execute command"
	end
	return result
end

local remove_last_empty = function(l)
	local r = {}
	for _, e in ipairs(l) do
		if e ~= "" then
			table.insert(r, e)
		end
	end
	return r
end

-- parse buffer to a list of messages
-- each message has first element as role, and the rest are content
local parse_messages = function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local messages = {}
	local message = {}
	local current_role = "user"
	table.insert(message, roles[current_role])
	for _, line in ipairs(lines) do
		local new_role = ""
		if line:match(roles["user"]) then
			new_role = "user"
		elseif line:match(roles["assistant"]) then
			new_role = "assistant"
		else
			table.insert(message, line)
		end

		if new_role ~= "" and new_role ~= current_role then
			table.insert(messages, remove_last_empty(message))
			message = {}
			current_role = new_role
			new_role = ""
			table.insert(message, roles[current_role])
		end
	end

	table.insert(messages, remove_last_empty(message)) -- insert last one

	return messages
end

local add_transcript_header = function(winnr, bufnr, role, line_num)
	local line = ((line_num ~= nil) and line_num) or vim.api.nvim_buf_line_count(bufnr)
	vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, { roles[role] })
	if role == "user" and buffer_sync_cursor[bufnr] then
		vim.schedule(function()
			local is_current = winnr == vim.api.nvim_get_current_win()
			vim.api.nvim_win_call(winnr, function()
				vim.cmd("normal! Go")
				if is_current then
					vim.cmd("startinsert!")
				end
			end)
		end)
	end
	return line
end

local init_chat = function()
	local winnr = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_get_current_buf()
	buffer_sync_cursor[bufnr] = true

	vim.wo.breakindent = true
	vim.wo.wrap = true
	vim.wo.linebreak = true

	vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
	vim.api.nvim_set_option_value("buflisted", true, { buf = bufnr })
	vim.api.nvim_set_option_value("modified", false, { buf = bufnr })

	add_transcript_header(winnr, bufnr, "user", 0)
	local modes = { "n", "i" }
	for _, mode in ipairs(modes) do
		vim.api.nvim_buf_set_keymap(
			bufnr,
			mode,
			"<C-s>",
			"<ESC>:lua require('xai').ChatBotSubmit()<CR>",
			{ noremap = true, silent = true }
		)
	end
end

local parse_response = function(response)
	local result = {}

	if response["ThreadID"] ~= nil then
		thread_id = response["ThreadID"]
	end

	if response["ChatRequest"] ~= nil and response["ChatRequest"]["messages"] ~= nil then
		for _, m in ipairs(response["ChatRequest"]["messages"]) do
			if m["role"] == "user" or m["role"] == "assistant" then
				table.insert(result, roles[m["role"]])
				local lines = split(m["content"], "\n")
				for _, l in ipairs(lines) do
					table.insert(result, l)
				end
				table.insert(result, "")
			end
		end
	end

	if response["ChatResponse"] ~= nil and response["ChatResponse"]["choices"] ~= nil then
		for _, c in ipairs(response["ChatResponse"]["choices"]) do
			local m = c["message"]
			if m["role"] == "user" or m["role"] == "assistant" then
				table.insert(result, roles[m["role"]])
				local lines = split(m["content"], "\n")
				for _, l in ipairs(lines) do
					table.insert(result, l)
				end
				table.insert(result, "")
			end
		end
	end

	return result
end

local done = function()
	local winnr = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_get_current_buf()

	vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr }) -- allow user input again
	is_receiving = false
	add_transcript_header(winnr, bufnr, "user")
end

local receive_data = function(_, data, _)
	local winnr = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_get_current_buf()
	if #data > 1 then
		local response = json.decode(data[1])
		local new_lines = parse_response(response)
		vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
		if buffer_sync_cursor[bufnr] then
			vim.schedule(function()
				vim.api.nvim_win_call(winnr, function()
					vim.cmd("normal! G$")
				end)
			end)
		end
	end
end

function M.Chat()
	vim.cmd("botright vnew")
	vim.cmd("set winfixwidth")
	vim.cmd("vertical resize 60")
	init_chat()
end

function M.ChatHistory()
	local command = "xai chat history"
	local result = execute_command(command)
	local fzf_run = vim.fn["fzf#run"]
	local fzf_wrap = vim.fn["fzf#wrap"]
	local wrapped = fzf_wrap("test", {
		source = split(result.output, "\n"),
	})

	wrapped["sink*"] = nil
	wrapped["sinklist"] = nil

	wrapped.sink = function(line)
		if line ~= nil and line ~= "" then
			init_chat()
			local t_minus = split(line, ")")[1]
			local resume_cmd = "xai chat resume " .. t_minus
			vim.fn.jobstart(resume_cmd, {
				on_stdout = receive_data,
				on_exit = done,
			})
		end
	end

	fzf_run(wrapped)
end

function M.ChatBotSubmit()
	if is_receiving then
		print("Already receiving")
		return
	end

	vim.cmd("normal! Go")
	local winnr = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_get_current_buf()
	buffer_sync_cursor[bufnr] = true

	local messages = parse_messages()
	local last_message = messages[#messages]
	local role = table.remove(last_message, 1)
	if role ~= roles["user"] then
		print("Missing user input")
		return
	end

	local user_input = table.concat(last_message, "\n")

	local prompt_cmd = 'xai prompt "' .. user_input .. '"'
	-- vim.print(prompt_cmd)
	if thread_id ~= nil and thread_id ~= "" then
		-- pass thread to the request
		prompt_cmd = prompt_cmd .. " --thread-id " .. thread_id
	end
	local job_id = vim.fn.jobstart(prompt_cmd, {
		on_stdout = receive_data,
		on_exit = done,
		on_stderr = function(_, _, _)
			-- vim.print(data)
		end,
	})

	if job_id > 0 then
		is_receiving = true
		add_transcript_header(winnr, bufnr, "assistant")
	end
end

return M
