set clipboard=unnamed
set mouse=nv
set number relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2
set list listchars=tab:\|_,trail:·,eol:↵
set cursorline cursorcolumn colorcolumn=81 signcolumn=yes
set splitbelow splitright
set smartindent
set completeopt=menuone,noselect
set noswapfile nobackup nowritebackup
set undodir=~/.vim/undodir undofile

let mapleader=","
lua require 'init'

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
