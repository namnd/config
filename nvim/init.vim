set clipboard=unnamedplus
set mouse=nv
set nu relativenumber
set listchars=tab:>~,nbsp:_,trail:.,eol:$
set list
set incsearch
set undodir=~/.vim/undodir
set undofile

set cursorline
set colorcolumn=80

call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'szw/vim-maximizer'
Plug 'mbbill/undotree'
Plug 'kshenoy/vim-signature'
Plug 'justinmk/vim-dirvish'


call plug#end()

colorscheme gruvbox
set background=dark

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

set splitbelow splitright
nmap <C-h> :wincmd h<cr>
nmap <C-j> :wincmd j<cr>
nmap <C-l> :wincmd l<cr>
nmap <C-k> :wincmd k<cr>

" fzf
let g:fzf_mru_relative = 1
let g:fzf_layout = {'down': '~40%'}
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--reverse'
nmap <C-p> :Files<cr>
nmap <C-e> :FZFMru<cr>
nmap <C-f> :Rg<cr>
nmap <C-b> :Buffers<cr>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<cr><cr>

nmap <C-n> <Plug>(dirvish_vsplit_up)
let g:dirvish_mode = ':sort ,^.*[\/],'	" sort folders at top

let mapleader=" "

nnoremap <leader>1 :e $MYVIMRC<cr>
nnoremap <leader>2 :so %<cr>
nnoremap <leader>9 :PlugInstall<cr>
nnoremap <leader>0 :PlugClean<cr>
nnoremap <leader>m :MaximizerToggle!<cr>
nnoremap <leader>u :UndotreeToggle<cr>
