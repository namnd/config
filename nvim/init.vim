set clipboard=unnamed
set mouse=nv
set number relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2
set list listchars=tab:\|_,trail:·,eol:↵
set cursorline cursorcolumn colorcolumn=81 signcolumn=yes
set noswapfile nobackup nowritebackup
set undodir=~/.vim/undodir undofile
set splitbelow splitright
set foldmethod=expr nofoldenable
set ignorecase smartcase
set foldexpr=nvim_treesitter#foldexpr()
set laststatus=2 statusline=\%n%m\ %t\ %r%y%=%w%l,%-10.c
set expandtab
set smartindent
set hidden
set updatetime=50
set scrolloff=8

call plug#begin()
Plug 'tweekmonster/startuptime.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-dirvish'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'hashivim/vim-terraform'
Plug 'jparise/vim-graphql'
Plug 'windwp/nvim-autopairs'
call plug#end()

set statusline+=%{FugitiveStatusline()}%{coc#status()}

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
nnoremap <silent> g3f :wincmd F<cr> :wincmd T<cr>

let mapleader=" "

" telescope
nnoremap <leader><leader> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>bb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ee :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<cr><cr>
nnoremap <C-f> :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<cr>
nnoremap <C-e> <cmd>Telescope coc mru<cr>
nnoremap <leader>cc <cmd>Telescope coc code_actions<cr>
nnoremap <leader>pp <cmd>lua require('telescope').extensions.project.project{}<cr>
nnoremap <leader>11 <cmd>lua require('nam.telescope').search_dotfiles()<cr>
nnoremap <leader>22 :so $MYVIMRC<cr>
nnoremap <leader>rp yiw<esc>:%s/<C-r>+//gc<left><left><left>
nnoremap <leader>nn :noh<cr>

nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gs :tab G<cr>
nnoremap <leader>gc :tabc<cr>

" dirvish
nmap <C-n> <Plug>(dirvish_vsplit_up)
nmap <C-m> <Plug>(dirvish_split_up)
let g:dirvish_mode = ':sort ,^.*[\/],'

" coc
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> g1d :sp<cr> <Plug>(coc-definition)
nmap <silent> g2d :vs<cr> <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)

autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 70})
autocmd WinEnter * set colorcolumn=81 cursorline cursorcolumn
autocmd WinLeave * set colorcolumn=0 nocursorline nocursorcolumn
autocmd VimResized * :wincmd =
autocmd BufNewFile,BufRead Jenkinsfile setf groovy

lua <<EOF
require'nvim-treesitter.configs'.setup { 
  highlight = { enable = true },
  indent = { enable = true },
  }
require('telescope').setup {
  defaults = {
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
      }
    }
  }
require('github-theme').setup()
require('nvim-autopairs').setup()
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('project')
require('telescope').load_extension('coc')
EOF
