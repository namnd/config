syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set backspace=indent,eol,start

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'https://github.com/ycm-core/YouCompleteMe'
Plug 'mbbill/undotree'

Plug 'mcchrish/nnn.vim'
call plug#end()


colorscheme gruvbox
set background=dark

let mapleader=" "

" fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>e :History<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>r :Rg<cr>

" YouCompleteMe
nnoremap <silent> <leader>gd :YcmCompleter GoTo<cr>
nnoremap <silent> <leader>gf :YcmCompleter FixIt<cr>

" nnn
let g:nnn#set_default_mappings = 0
let g:nnn#layout = {'window': {'width': 0.9, 'height': 0.7, 'highlight': 'Debug' } }
let g:nnn#command = 'nnn -H'
let g:nnn#action = {
    \ '<c-x>': 'split',
    \ '<c-v>': 'vsplit',
    \ '<c-t>': 'tab split' }
nnoremap <silent> <leader>nn :NnnPicker<CR>
