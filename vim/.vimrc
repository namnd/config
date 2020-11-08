syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set cursorline
set mouse=
set ttymouse=

set backspace=indent,eol,start
set foldmethod=indent
set nofoldenable

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'mcchrish/nnn.vim'
Plug 'neoclide/coc.nvim'
Plug 'kshenoy/vim-signature'

call plug#end()

" gruvbox
colorscheme gruvbox
set background=dark

" lightline
set laststatus=2

imap jj <esc>
vmap jj <esc>

set splitbelow splitright
nmap <silent> zs :wincmd s<cr>
nmap <silent> zv :wincmd v<cr>
nmap <silent> zx :wincmd x<cr>
nmap <silent> zo :wincmd o<cr>

nmap <silent> zh :wincmd h<cr>
nmap <silent> zj :wincmd j<cr>
nmap <silent> zl :wincmd l<cr>
nmap <silent> zk :wincmd k<cr>

let mapleader=" "

nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr>
nnoremap <leader>u :UndotreeToggle<cr>

" fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>e :History<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>r :Rg<cr>

" fzf checkout
nnoremap <leader>gc :GCheckout<cr>

" nnn
let g:nnn#set_default_mappings = 0
let g:nnn#layout = {'window': {'width': 0.9, 'height': 0.7, 'highlight': 'Debug' } }
let g:nnn#command = 'nnn -H'
let g:nnn#action = {
    \ '<c-x>': 'split',
    \ '<c-v>': 'vsplit',
    \ '<c-t>': 'tab split' }
nnoremap <silent> <leader>nn :NnnPicker<CR>

" git
nmap <leader>gh :diffget //3<cr>
nmap <leader>gf :diffget //2<cr>

" coc
set hidden
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

