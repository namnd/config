local notes_path = vim.fn.getcwd() -- os.getenv("HOME") .. "/notes"
local scratch = notes_path .. "/scratch"

vim.api.nvim_create_user_command('S', ":edit " .. scratch, {})
vim.api.nvim_create_user_command('SS', ":split " .. scratch, {})
vim.api.nvim_create_user_command('SV', ":vsplit " .. scratch, {})
vim.api.nvim_create_user_command('ST', ":tabedit " .. scratch, {})

vim.cmd [[
command! -bang -nargs=* SG
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob 'scratch' ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': '~/'}), <bang>0)
]]
