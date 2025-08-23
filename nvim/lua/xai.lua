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

M = {}

---@diagnostic disable-next-line: duplicate-set-field
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
			local chat_buf = vim.api.nvim_create_buf(true, true)
			vim.api.nvim_command("vsplit")
			vim.api.nvim_win_set_buf(0, chat_buf)
			vim.api.nvim_set_option_value("filetype", "markdown", { buf = chat_buf })
			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
		end
	end

	fzf_run(wrapped)
end

return M
