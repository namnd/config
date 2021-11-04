require('plugins')
require('setup')
require('settings')
require('utils')
require('bindings')

vim.cmd [[
colorscheme tender
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup

let g:dirvish_mode=':sort ,^.*[\/],'
let g:vsnip_snippet_dir='~/.config/nvim/snippets'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
autocmd FileType git,gitcommit setlocal foldmethod=syntax foldenable
]]
