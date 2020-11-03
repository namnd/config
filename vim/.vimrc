let uname = substitute(system('uname'), '\n', '', '') " OS type
if uname == 'Darwin'
    set clipboard=unnamed
endif
if uname == 'Linux'
    set clipboard=unnamedplus
endif
syntax on

filetype plugin indent on       " filetype detection[ON] plugin[ON] indent[ON]
set backspace=indent,eol,start  " make backspace works
set listchars=tab:>~,nbsp:_,trail:.
set list
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab                   " use spaces instead of tabs
set smarttab                    " use tabs at the start of the line
set smartindent
set showmatch                   " show match bracket
set number relativenumber       " show both line number and relative
set incsearch                   " highlight as you type your search
set encoding=utf-8              " how vim represents characters on the screen
set fileencoding=utf-8          " set the encoding of files written
set noerrorbells visualbell     " flash screen instead of beep sound
set noswapfile
set cursorline                  " highlight cursor line
set cursorcolumn                " highlight cursor column
set mouse=                      " select text using mouse to enable visual mode
set ttymouse=
set foldmethod=indent
set foldnestmax=10
set nofoldenable            " disable auto folding
set foldlevel=2

colorscheme gruvbox
set background=dark

set laststatus=2
set statusline= " reset statusline
set statusline+=\ %n            " buffer number
set statusline+=\ %{statusline#git()}
set statusline+=%m              " modified flag
set statusline+=%r              " read only flag
" set statusline+=\ %{statusline#filepath()}
set statusline+=\ %f              " tail of filename
set statusline+=\ %{statusline#classname()}
set statusline+=%=              " left/right separator
set statusline+=[%{statusline#filetype()}]
set statusline+=\%{statusline#fileencoding()}
set statusline+=\[%{&ff}\]      " file format
set statusline+=\ %c,           " cursor column
set statusline+=\ %l/%L         " cursor line/total lines

" basic mapping
let mapleader=" "
inoremap {<Enter> {<cr>}<C-c>O
vnoremap <C-r> y<esc>:%s/<C-r>+//gc<left><left><left>
nnoremap Y y$

" split & navigation
set splitbelow splitright
nmap <silent> zh :wincmd h<cr>
nmap <silent> zj :wincmd j<cr>
nmap <silent> zk :wincmd k<cr>
nmap <silent> zl :wincmd l<cr>
nmap <silent> zv :wincmd v<cr>
nmap <silent> zs :wincmd s<cr>
nmap <silent> zx :wincmd x<cr>
nmap <silent> zr :wincmd r<cr>
nmap <silent> zo :wincmd o<cr>
nmap <silent> zf :vertical wincmd f<cr>
nnoremap <silent> z= :vertical resize +10<cr>
nnoremap <silent> z- :vertical resize -10<cr>
nnoremap <silent> z+ :resize +5<cr>
nnoremap <silent> z_ :resize -5<cr>


" fzf
set rtp+=~/dotfiles/fzf
let g:fzf_layout = { 'window': {
                    \ 'width': 0.9,
                    \ 'height': 0.7,
                    \ 'highlight': 'Comment',
                    \ 'rounded': v:false }}
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>e :History<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>r :Rg<cr>
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

" coc.nvim - autocompletion only
set hidden                      " TextEdit might fail if hidden is not set
set nobackup                    " some servers have issues with backup files
set nowritebackup
set cmdheight=2                 " give more spaces for displaying messages
set updatetime=100              " default is 4000ms = 4s
set shortmess+=c                " don't pass messages to ins-completion-menu
set signcolumn=yes              " always show the signcolumn
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Coc goto navigation
function! GoCoc()
    nmap <silent> gd <Plug>(coc-definition)
endfunction

" go lang
let g:go_template_autocreate = 0
function! Golang()
    nmap <buffer> <silent> <leader>tt :GoTest<cr>
    nmap <buffer> <silent> <leader>tn :GoTestFunc<cr>
endfunction

" closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

autocmd FileType go :call Golang()
autocmd FileType ts :call GoCoc()
