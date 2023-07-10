local notes_path = vim.fn.getcwd() -- os.getenv("HOME") .. "/notes"
local scratch = notes_path .. "/scratch"

vim.api.nvim_create_user_command('S', ":edit " .. scratch, {})
vim.api.nvim_create_user_command('SS', ":split " .. scratch, {})
vim.api.nvim_create_user_command('SV', ":vsplit " .. scratch, {})
vim.api.nvim_create_user_command('ST', ":tabedit " .. scratch, {})
vim.api.nvim_create_user_command('SG', function()
  require("telescope.builtin").live_grep {
    cwd = notes_path,
    prompt_title = "Search for notes",
  }
end, {})
