require('namnd.globals')
require('basic')
require('plugins')
require('setup')
require('bindings')
require('lsp')
require('debugger')
require('autocompletion')
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
require('namnd.telescope')
require('namnd.treesitter')

vim.cmd [[
colorscheme namnd
set undodir=~/.vim/undodir undofile
set noswapfile nobackup nowritebackup
set laststatus=2
set statusline=\%n%m\ %t\ %r%y
set statusline+=%{FugitiveStatusline()}%{get(b:,'gitsigns_status','')}
set statusline+=%=\ %{ObsessionStatus('(S)','')}\ %w%l,%-10.c%L

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
  autocmd BufRead * autocmd FileType <buffer> ++once if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
augroup END
]]
