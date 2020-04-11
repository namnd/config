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
set nowrap                      " disable wrapping
set incsearch                   " highlight as you type your search
set encoding=utf-8              " how vim represents characters on the screen
set fileencoding=utf-8          " set the encoding of files written
set noerrorbells visualbell     " flash screen instead of beep sound
set noswapfile
set cursorline                  " highlight cursor line
set cursorcolumn                " highlight cursor column
set mouse=a                     " select text using mouse to enable visual mode

colorscheme gruvbox
set background=dark

let mapleader=" "

" fzf
set rtp+=/home/nam/dotfiles/fzf
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
