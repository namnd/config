-- Forked of https://github.com/wolffiex/shellbot/blob/main/chatbot.lua
---@diagnostic disable: duplicate-set-field

M = {}

local roles = {
	USER = "🧑 " .. os.getenv("USER"),
	ASSISTANT = "🤖 xAI",
}

local separator = "---"

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

local add_transcript_header = function(winnr, bufnr, role, line_num)
	local line = ((line_num ~= nil) and line_num) or vim.api.nvim_buf_line_count(bufnr)
	vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, { roles[role] })
	if role == "USER" and buffer_sync_cursor[bufnr] then
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
	vim.api.nvim_set_option_value("filetype", "shellbot", { buf = bufnr })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
	vim.api.nvim_set_option_value("buflisted", true, { buf = bufnr })
	vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
	add_transcript_header(winnr, bufnr, "USER", 0)
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

function M.chat_history()
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
			local t_minus = split(line, ")")[1]
			result = execute_command("xai chat resume " .. t_minus)
			local lines = split(result.output, "\n")
			local new_lines = {}
			for _, l in ipairs(lines) do
				if l == "---" then
					table.insert(new_lines, " ")
				end
				table.insert(new_lines, l)
			end
			local chat_buf = vim.api.nvim_create_buf(true, true)
			vim.api.nvim_command("vsplit")
			vim.api.nvim_win_set_buf(0, chat_buf)
			vim.api.nvim_set_option_value("filetype", "markdown", { buf = chat_buf })
			vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
		end
	end

	fzf_run(wrapped)
end

local get_user_input = function(transcript)
	local user_input = {}
	local is_user_input = false

	for _, line in ipairs(transcript) do
		if line == separator .. "USER" .. separator then
			is_user_input = true
		elseif line == separator .. "ASSISTANT" .. separator then
			if is_user_input then
				break
			end
		elseif is_user_input then
			table.insert(user_input, line)
		end
	end

	return table.concat(user_input, "\n")
end

function M.Chat()
	vim.cmd("botright vnew")
	vim.cmd("set winfixwidth")
	vim.cmd("vertical resize 60")
	init_chat()
end

function M.ChatBotSubmit()
	vim.cmd("normal! Go")
	local winnr = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_get_current_buf()
	buffer_sync_cursor[bufnr] = true

	local get_transcript = function()
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		for i, line in ipairs(lines) do
			if line:match(roles["USER"]) then
				lines[i] = separator .. "USER" .. separator
			elseif line:match(roles["ASSISTANT"]) then
				lines[i] = separator .. "ASSISTANT" .. separator
			end
		end
		return lines
	end

	local transcript = get_transcript()
	-- vim.print(transcript)
	local user_input = get_user_input(transcript)
	-- vim.print(user_input)

	local receive_data = function(_, data, _)
		if #data > 1 or data[1] ~= "" then
			local current_line = vim.api.nvim_buf_line_count(bufnr)
			local col = #vim.api.nvim_buf_get_lines(bufnr, current_line - 1, current_line, false)[1]

			current_line = current_line - 1
			-- print("data " .. current_line .. "," .. col)

			-- - {data}	    Raw data (|readfile()|-style list of strings) read from
			-- the channel. EOF is a single-item list: `['']`. First and
			-- last items may be partial lines! |channel-lines|
			vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
			for i, new_text in ipairs(data) do
				-- new_text = "[" .. new_text .. "]"
				-- print(i .. ": " .. new_text .. " :" .. current_line .."," .. col .. "|" .. #new_text)
				if i == 1 then
					if #new_text > 0 then
						vim.api.nvim_buf_set_text(bufnr, current_line, col, current_line, col, { new_text })
						col = col + #new_text
					end
				else
					current_line = current_line + 1
					vim.api.nvim_buf_set_lines(bufnr, current_line, current_line, false, { new_text })
					col = #new_text
				end
			end
			if buffer_sync_cursor[bufnr] then
				vim.schedule(function()
					vim.api.nvim_win_call(winnr, function()
						vim.cmd("normal! G$")
					end)
				end)
			end
		end
	end
	local done = function()
		vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
		add_transcript_header(winnr, bufnr, "USER")
	end

	local prompt_cmd = "xai prompt " .. user_input
	local job_id = vim.fn.jobstart(prompt_cmd, {
		on_stdout = receive_data,
		on_exit = done,
	})

	if job_id > 0 then
		add_transcript_header(winnr, bufnr, "ASSISTANT")
	end
end

return M
