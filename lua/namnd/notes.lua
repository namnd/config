local notes_dir = os.getenv("HOME") .. "/notes"
local note_filename = vim.fn.getcwd():gsub("/", "%%")
local note_file = notes_dir .. "/" .. note_filename .. ".md"
local scratch_symlink = vim.fn.getcwd() .. "/scratch"
os.execute("touch " .. note_file)
os.execute("ln -sf " .. note_file .. " " .. scratch_symlink)

vim.api.nvim_create_user_command('S', ":edit " .. scratch_symlink, {})
vim.api.nvim_create_user_command('SS', ":split " .. scratch_symlink, {})
vim.api.nvim_create_user_command('SV', ":vsplit " .. scratch_symlink, {})
vim.api.nvim_create_user_command('ST', ":tabedit " .. scratch_symlink, {})

vim.cmd [[
command! -bang -nargs=* SG
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': '~/notes'}), <bang>0)
]]
