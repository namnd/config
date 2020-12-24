
call plug#begin('~/.vim/plugged')

Plug 'tweekmonster/startuptime.vim'
Plug 'jacoborus/tender.vim'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

call plug#end()

colorscheme tender

nnoremap vw vaw
nnoremap yw yaw
nnoremap dw daw
nnoremap Y y$
vnoremap v $h
xnoremap <C-x> <esc>`.``gvP``P
nmap <C-h> :wincmd h<cr>
nmap <C-j> :wincmd j<cr>
nmap <C-l> :wincmd l<cr>
nmap <C-k> :wincmd k<cr>
nmap <C-c> :wincmd o<cr>

let mapleader=" "

nnoremap <leader>11 :e $MYVIMRC<cr>
nnoremap <leader>12 :vs $MYVIMRC<cr>
nnoremap <leader>13 :tab sp $MYVIMRC<cr>
nnoremap <leader>2 :so $MYVIMRC<cr>
nnoremap <leader>9 :PlugInstall<cr>
nnoremap <leader>0 :PlugClean<cr>

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
autocmd WinEnter * set colorcolumn=81
autocmd WinLeave * set colorcolumn=0
autocmd VimResized * :wincmd =

" fzf
nmap <C-p> :Files<cr>
nmap <C-e> :FZFMru<cr>
nmap <C-f> :Rg<cr>
nmap <C-b> :Buffers<cr>
let g:fzf_mru_relative = 1
let g:fzf_layout = {'down': '~40%'}
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--reverse'
