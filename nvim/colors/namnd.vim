" The default neovim colorscheme is almost perfect for me, so there are not
" a whole lot change here

let colors_name = "namnd"

hi Normal guibg=#111111 " almost black

" less important
hi Type gui=none guifg=#aaaaaa
hi Statement gui=none guifg=#a8a8a8
hi Constant guifg=#a8a8a8
hi String guifg=#6c6c6c

" more important stuff
hi Identifier guifg=#60d7ff " light blue
hi Function guifg=#60d7ff

" other minor
hi WinBar guifg=Magenta gui=none
hi CursorLine guibg=#222222
hi ColorColumn guibg=#222222
hi StatusLine guibg=#222222 guifg=#a8a8a8

augroup ColorColumnHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=81 cursorline
  autocmd WinLeave * set colorcolumn=0 nocursorline
augroup END

highlight Directory guifg=#1a8fff " blue
