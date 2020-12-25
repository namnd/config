set clipboard=unnamedplus
set mouse=nv
set number relativenumber
set tabstop=4 softtabstop=4 shiftwidth=4
set list listchars=tab:\|_,trail:·,eol:¶
set cursorline cursorcolumn colorcolumn=81 signcolumn=yes
set noswapfile nobackup nowritebackup
set undodir=~/.vim/undodir undofile
set splitbelow splitright
set foldmethod=indent nofoldenable
set laststatus=2 statusline=\%n%m\ %t\ %r%y%=%w%L,%-10.c
set expandtab
set smartindent
" set hidden
" set cmdheight=2
" set updatetime=50
" set completeopt=menuone,noinsert,noselect
" set shortmess+=c

call plug#begin()
Plug 'tweekmonster/startuptime.vim'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'wellle/targets.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
" Plug 'szw/vim-maximizer'
" Plug 'mbbill/undotree'
" Plug 'kshenoy/vim-signature'
" Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
if has('nvim-0.5')
    Plug 'nvim-treesitter/nvim-treesitter'
endif
Plug 'editorconfig/editorconfig-vim'

call plug#end()

set statusline+=%{FugitiveStatusline()}
colorscheme tender

vnoremap v $h
nnoremap Y y$
nnoremap vw vaw
nnoremap yw yaw
nnoremap dw daw
nnoremap cw caw
nnoremap <C-h> :wincmd h<cr>
nnoremap <C-j> :wincmd j<cr>
nnoremap <C-l> :wincmd l<cr>
nnoremap <C-k> :wincmd k<cr>
nnoremap <C-s> :wincmd r<cr>
nnoremap <C-c> :wincmd o<cr>
nnoremap <silent> g1f :wincmd F<cr> :wincmd K<cr> :wincmd r<cr>
nnoremap <silent> g2f :wincmd F<cr> :wincmd H<cr> :wincmd r<cr>
xnoremap <C-x> <esc>`.``gvP``P
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

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
" nnoremap <leader>mm :MaximizerToggle!<cr>
" nnoremap <leader>uu :UndotreeToggle<cr>
" nnoremap <leader>ta :Vista finder coc<cr>

" fzf
nnoremap <C-p> :Files<cr>
nnoremap <C-e> :FZFMru<cr>
nnoremap <C-b> :Buffers<cr>
nnoremap <C-f> :Rg<cr>
nnoremap <leader>rg :Rg <C-R>=expand('<cword>')<cr><cr>
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

autocmd WinEnter * set colorcolumn=81
autocmd WinLeave * set colorcolumn=0
autocmd VimResized * :wincmd =

if has('nvim-0.5')
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
endif
