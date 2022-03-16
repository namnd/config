require('basic')
require('plugins')
require('setup')
require('bindings')
require('lsp')
require('autocompletion')
require('snippets')

vim.cmd [[
colorscheme namnd
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set laststatus=2
set statusline=\%n%m\ %t\ %r%y
set statusline+=%{FugitiveStatusline()}%{get(b:,'gitsigns_status','')}
set statusline+=%=%w%l,%-10.c%L

let g:dirvish_mode=':sort ,^.*[\/],'
let g:fzf_mru_relative=1

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline
autocmd WinLeave * set colorcolumn=0 nocursorline
autocmd VimResized * :wincmd =
autocmd FileType git,gitcommit setlocal foldmethod=syntax foldenable
autocmd FileType yml,yaml setlocal foldmethod=indent
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
]]
