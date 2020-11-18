syntax on

let uname = substitute(system('uname'), '\n', '', '') " OS type
if uname == 'Darwin'
  set clipboard=unnamed
endif
if uname == 'Linux'
  set clipboard=unnamedplus
endif

set report=0
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
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
set listchars=tab:>~,nbsp:_,trail:.,eol:$
set list
set showcmd

set backspace=indent,eol,start
set foldmethod=indent
set nofoldenable

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim'
Plug 'kshenoy/vim-signature'
Plug 'lambdalisue/fern.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'
Plug 'rhysd/clever-f.vim'
Plug 'tmsvg/pear-tree'
Plug 'fatih/vim-go'

call plug#end()

" gruvbox
colorscheme gruvbox
set background=dark

set laststatus=2
set statusline=\(%n)                    " buffer number
set statusline+=\ %F                    " full path to file in the buffer
set statusline+=\ %m                    " modified flag in square brackets
set statusline+=%r                      " readonly flag in square brackets
set statusline+=%y                      " syntax in square brackets
set statusline+=%{FugitiveStatusline()}
set statusline+=%{coc#status()}
set statusline+=%=                      " left/right separator
set statusline+=%h                      " help flag in square brackets
set statusline+=%w
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&ff}]             " file format
set statusline+=C:%-10.c                " cursor column
set statusline+=\ L:%l/%L\              " cursor lines

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

set splitbelow splitright
nmap <silent> zs :wincmd s<cr>
nmap <silent> zv :wincmd v<cr>
nmap <silent> zx :wincmd x<cr>
nmap <silent> zo :wincmd o<cr>

nmap <silent> zh :wincmd h<cr>
nmap <silent> zj :wincmd j<cr>
nmap <silent> zl :wincmd l<cr>
nmap <silent> zk :wincmd k<cr>
nmap <silent> zf :wincmd F<cr> :wincmd H<cr>

let mapleader=" "

nnoremap <leader>rp yiw<esc>:%s/<C-r>+//gc<left><left><left>
nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr> :e<cr>
nnoremap <leader>u :UndotreeToggle<cr>

" fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_mru_relative = 1
nmap <C-p> :Files<cr>
nmap <C-e> :FZFMru<cr>
nmap <C-f> :Rg<cr>
nmap <C-b> :Buffers<cr>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<cr><cr>

" fzf checkout
nnoremap <leader>gc :GCheckout<cr>

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
nmap <silent> gsd :split<cr><Plug>(coc-definition)
nmap <silent> gvd :vsplit<cr><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)

let g:coc_global_extension = [
      \ 'coc-tsserver'
      \]
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extension += ['coc-eslint']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extension += ['coc-prettier']
endif
" resolve workspace for Django
autocmd FileType python let b:coc_root_patterns = ['manage.py']

" fern tree
nmap <C-n> :Fern . -drawer -keep -toggle -width=40<cr><C-w>=
nmap <C-m> :Fern . -drawer -keep -toggle -reveal=%<cr><C-w>=
function! s:init_fern() abort
  nmap <buffer> e <Plug>(fern-action-open:select)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
endfunction

augroup fern-custom
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

let g:highlightedyank_highlight_duration = 50
let g:indentLine_color_term = 239
let g:vim_json_conceal = 0
