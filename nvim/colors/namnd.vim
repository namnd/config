" The default neovim colorscheme is almost perfect for me, so there are not
" a whole lot change here

let colors_name = "namnd"

hi Normal             guibg=#111111 " almost black
hi CursorLine         guibg=#222222
hi ColorColumn        guibg=#222222
hi DiffText           guibg=orange    guifg=black
hi StatusLine         guibg=#222222   guifg=#a8a8a8
hi StatusLineNC       guibg=none      guifg=#a8a8a8
hi Directory          guifg=#1a8fff " blue
hi DiagnosticError    guifg=red
hi DiagnosticWarn     guifg=yellow
hi WinBar             guibg=none      guifg=magenta

" less important
hi Type               guibg=none      guifg=#aaaaaa
hi Statement          guibg=none      guifg=#a8a8a8
hi Constant                           guifg=#a8a8a8
hi String                             guifg=#6c6c6c

augroup ColorColumnHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=81 cursorline
  autocmd WinLeave * set colorcolumn=0 nocursorline
augroup END
