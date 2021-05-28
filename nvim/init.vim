filetype plugin on
set clipboard=unnamed
set mouse=nv
set number relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2
set list listchars=tab:\|_,trail:·,eol:¶
set cursorline cursorcolumn colorcolumn=81 signcolumn=yes
set noswapfile nobackup nowritebackup
set undodir=~/.vim/undodir undofile
set splitbelow splitright
set foldmethod=syntax nofoldenable
set laststatus=2 statusline=\%n%m\ %t\ %r%y%=%w%l,%-10.c
set expandtab
set smartindent
set hidden
set updatetime=50
set scrolloff=8

call plug#begin()
Plug 'tweekmonster/startuptime.vim'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-dirvish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jparise/vim-graphql'
call plug#end()

set statusline+=%{FugitiveStatusline()}%{coc#status()}
colorscheme tender

vnoremap v $h
nnoremap Y y$
nnoremap cw caw
nnoremap E ea
nnoremap <C-t> :tabnew<cr>
nnoremap <C-h> :wincmd h<cr>
nnoremap <C-j> :wincmd j<cr>
nnoremap <C-l> :wincmd l<cr>
nnoremap <C-k> :wincmd k<cr>
nnoremap <silent> g1f :wincmd F<cr> :wincmd K<cr> :wincmd r<cr>
nnoremap <silent> g2f :wincmd F<cr> :wincmd H<cr> :wincmd r<cr>
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap ({<cr> ({<cr>})<esc>O
inoremap =>{ => {<cr>})<esc>O

let mapleader=" "

nnoremap <leader>11 :e $MYVIMRC<cr>
nnoremap <leader>12 :vs $MYVIMRC<cr>
nnoremap <leader>13 :tab sp $MYVIMRC<cr>
nnoremap <leader>2 :so $MYVIMRC<cr>
nnoremap <leader>9 :PlugInstall<cr>
nnoremap <leader>0 :PlugClean<cr>
nnoremap <leader>rp yiw<esc>:%s/<C-r>+//gc<left><left><left>
nnoremap <leader>nn :noh<cr>
nnoremap <leader>gs :tab G<cr>
nnoremap <leader>gc :tabc<cr>

" fzf
nnoremap <C-p> :Files<cr>
nnoremap <C-e> :FZFMru<cr>
nnoremap <C-b> :Buffers<cr>
nnoremap <C-f> :Rg<cr>
let g:fzf_mru_relative = 1
let g:fzf_layout = {'down': '~40%'}
let $FZF_DEFAULT_OPTS = '--reverse'

" dirvish
nmap <C-n> <Plug>(dirvish_vsplit_up)
let g:dirvish_mode = ':sort ,^.*[\/],'

" coc
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> g1d :sp<cr> <Plug>(coc-definition)
nmap <silent> g2d :vs<cr> <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>cc <Plug>(coc-codeaction)
xmap <leader>ff <Plug>(coc-format-selected)
nnoremap <leader>cs :CocSearch <C-R>=expand('<cword>')<cr><cr>

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
