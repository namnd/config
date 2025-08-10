-- Notes scratch buffer
M = {}

vim.filetype.add({
	filename = {
		["scratch"] = "markdown",
	},
})

---@diagnostic disable-next-line: duplicate-set-field
function M.edit()
	local notes_dir = os.getenv("HOME") .. "/notes"
	os.execute("mkdir -p " .. notes_dir)
	local note_filename = vim.fn.getcwd():gsub("/", "%%")
	local note_file = notes_dir .. "/" .. note_filename .. ".md"
	local scratch_symlink = vim.fn.getcwd() .. "/scratch"
	os.execute("touch " .. note_file)
	os.execute("ln -sf " .. note_file .. " " .. scratch_symlink)
	vim.cmd("edit scratch")
end

return M
