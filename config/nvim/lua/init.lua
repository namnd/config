require('namnd.globals')
require('basic')
require('plugins')
require('setup')
require('bindings')
require('lsp')
require('debugger')
require('autocompletion')
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
require('namnd.telescope')
require('namnd.treesitter')

vim.cmd [[
colorscheme namnd
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set winbar=%m\ %f\ (%n)%=%P\ %r%y
set laststatus=3
set statusline=%!v:lua.require('namnd.statusline').global()

let g:dirvish_mode=':sort ,^.*[\/],'

augroup Personal
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
  autocmd WinEnter * set colorcolumn=81 cursorline
  autocmd WinLeave * set colorcolumn=0 nocursorline
  autocmd VimResized * :wincmd =
  autocmd FileType git,gitcommit setlocal foldmethod=syntax foldenable
  autocmd FileType yml,yaml setlocal foldmethod=indent
  autocmd FileType Outline set wrap!
  autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
  autocmd BufNewFile,BufRead *.tfvars set filetype=terraform
  autocmd BufNewFile,BufRead *.hujson set filetype=json
augroup END
]]

vim.api.nvim_create_augroup("ObsessionCheck", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = "ObsessionCheck",
  callback = function()
    local status = vim.api.nvim_exec([[ echo ObsessionStatus() ]], true)
    if status ~= "[$]" then
      vim.api.nvim_command('silent! Obsession')
    end
  end
})
