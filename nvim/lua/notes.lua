-- Notes scratch buffer
local notes_dir = os.getenv("HOME") .. "/notes"
os.execute("mkdir -p " .. notes_dir)
local note_filename = vim.fn.getcwd():gsub("/", "%%")
local note_file = notes_dir .. "/" .. note_filename .. ".md"
local scratch_symlink = vim.fn.getcwd() .. "/scratch"
os.execute("touch " .. note_file)
os.execute("ln -sf " .. note_file .. " " .. scratch_symlink)

vim.api.nvim_create_user_command("S", ":edit " .. scratch_symlink, {})
vim.api.nvim_create_user_command("SS", ":split " .. scratch_symlink, {})
vim.api.nvim_create_user_command("SV", ":vsplit " .. scratch_symlink, {})
vim.api.nvim_create_user_command("ST", ":tabedit " .. scratch_symlink, {})
