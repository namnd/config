set clipboard=unnamedplus
set mouse=nv
set nu relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set smartindent
set listchars=tab:>~,nbsp:_,trail:.,eol:$
set list
set incsearch
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set cursorline
set colorcolumn=81
set signcolumn=yes
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set foldmethod=indent
set nofoldenable

call plug#begin()

Plug 'lifepillar/vim-gruvbox8'
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
Plug 'tmsvg/pear-tree'
Plug 'tweekmonster/startuptime.vim'
Plug 'wellle/targets.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

set termguicolors
colorscheme gruvbox8
set background=dark

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nnoremap ; :
inoremap jj <esc>
" selects til end of line (exclude newline)
vnoremap v $h 
nnoremap Y y$
" swap highlighted text with last deleted text
xnoremap <C-x> <Esc>`.``gvP``P
 
let mapleader=" "

set splitbelow splitright
nmap <C-h> :wincmd h<cr>
nmap <C-j> :wincmd j<cr>
nmap <C-l> :wincmd l<cr>
nmap <C-k> :wincmd k<cr>
nmap <C-s> <C-^>
nmap <C-x> :wincmd x<cr>
nmap <C-c> :wincmd o<cr>

" fzf
let g:fzf_mru_relative = 1
let g:fzf_layout = {'down': '~40%'}
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--reverse'
nmap <C-p> :Files<cr>
nmap <C-e> :FZFMru<cr>
nmap <C-f> :Rg<cr>
nmap <C-b> :Buffers<cr>

" dirvish - project drawer
nmap <C-n> <Plug>(dirvish_vsplit_up)
let g:dirvish_mode = ':sort ,^.*[\/],'	" sort folders at top

nnoremap <leader>11 :e $MYVIMRC<cr>
nnoremap <leader>12 :vs $MYVIMRC<cr>
nnoremap <leader>13 :tab sp $MYVIMRC<cr>
nnoremap <leader>2 :so %<cr>
nnoremap <leader>9 :PlugInstall<cr>
nnoremap <leader>0 :PlugClean<cr>
nnoremap <leader>mm :MaximizerToggle!<cr>
nnoremap <leader>uu :UndotreeToggle<cr>
nnoremap <leader>nn :noh<cr>

" lsp config
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}

nmap <silent> gF :wincmd F<cr> :wincmd H<cr>
nmap <silent> gd :wincmd s<cr> :lua vim.lsp.buf.definition()<cr>
nmap <silent> gD :wincmd v<cr> :lua vim.lsp.buf.definition()<cr>
nmap <silent> gr :lua vim.lsp.buf.references()<cr>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

nnoremap <leader>ca :lua vim.lsp.buf.code_action()<cr>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<cr>
nnoremap <leader>rp yiw<esc>:%s/<C-r>+//gc<left><left><left>
nnoremap <leader>rg :Rg <C-R>=expand('<cword>')<cr><cr>

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
augroup END

function! s:init_ts() abort
  nmap <leader>tt :vsplit term://npm test<cr>
  nmap <leader>ll :vsplit term://npm run lint<cr>
endfunction
autocmd FileType typescript,typescript.tsx :call s:init_ts()
autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <c-r><c-g><cr>
autocmd BufWritePost *.ts,*.tsx lua vim.lsp.buf.formatting()
autocmd VimResized * :wincmd =
