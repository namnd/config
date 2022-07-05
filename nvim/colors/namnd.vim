let colors_name = "namnd"

hi Normal         ctermfg=White      ctermbg=Black
hi NonText        ctermfg=DarkGrey
hi Constant       ctermfg=Grey
hi Comment        ctermfg=DarkGrey   cterm=italic
hi Todo           ctermfg=Yellow     cterm=bold     ctermbg=none
hi WarningMsg     ctermfg=Red        cterm=bold     ctermbg=none

hi Statement      ctermfg=Grey
hi Identifier     cterm=none         ctermfg=LightBlue
hi Visual         ctermfg=bg         ctermbg=fg

hi MatchParen     ctermbg=none       ctermfg=Magenta  cterm=bold
hi Special        ctermfg=DarkCyan
hi Delimiter      ctermfg=DarkCyan

hi LineNr         ctermfg=DarkGrey   ctermbg=Black
hi CursorLineNr   cterm=none         ctermfg=White
hi CursorLine     cterm=none
hi SignColumn     ctermbg=Black
hi ColorColumn    ctermbg=DarkGrey
hi VertSplit      cterm=none         ctermfg=DarkGrey

hi DiagnosticWarn ctermfg=DarkYellow
hi DiagnosticFloatingError ctermfg=LightRed

hi FoldColumn     ctermbg=Black      ctermfg=LightGrey
hi Folded         ctermbg=DarkGrey   ctermfg=LightGrey

hi DiffAdd        ctermbg=DarkGreen  ctermfg=fg
hi DiffChange     ctermbg=Brown      ctermfg=fg
hi DiffDelete     ctermbg=DarkRed    ctermfg=fg

hi GitSignsAdd    ctermfg=DarkGreen
hi GitSignsChange ctermfg=Brown
hi GitSignsDelete ctermfg=DarkRed

hi TabLineFill    cterm=none
hi TabLineSel     cterm=none         ctermfg=White
hi TabLine        cterm=none         ctermbg=none ctermfg=DarkGrey

hi Pmenu          ctermfg=0          ctermbg=DarkGrey
hi Directory      ctermfg=Blue
hi PmenuSel       ctermfg=Black      ctermbg=White

hi StatusLine     term=bold,reverse  ctermbg=Grey ctermfg=Black cterm=none
hi StatusLineNC   term=none          cterm=none   ctermfg=LightGrey

hi DapUIBreakpointsCurrentLine ctermfg=Green
" hi DanUIBreakbointsDisabledLine ctermfg=Grey
" hi DapUIBreakpointsInfo ctermfg=Green
hi link DapUIBreakpointsLine DapUIBreakpointsCurrentLine
hi DapUIBreakpointsPath ctermfg=Yellow
hi DapUIDecoration ctermfg=Green
" hi DapUIFloatBorder ctermbg=Blue
" hi link DapUIFrameName Normal
hi DapUILineNumber ctermfg=DarkGrey
hi DapUIModifiedValue ctermfg=Yellow
hi DapUIScope ctermfg=Blue
hi DapUISource ctermfg=Yellow
hi DapUIStoppedThread ctermfg=Blue
hi DapUIThread ctermfg=Blue
hi DapUIType ctermfg=DarkGrey
hi DapUIValue ctermfg=DarkGrey
" hi link DapUIVariable Normal
hi DapUIWatchesHeader ctermfg=Blue
hi DapUIWatchesEmpty ctermfg=DarkGrey
hi DapUIWatchesValue ctermfg=Green
hi DapUIWatchesError ctermfg=Red
" hi DapUIWatchesFrame ctermfg=Green

augroup BgStatusLine
  autocmd!
  au InsertEnter * hi StatusLine ctermbg=White
  au InsertLeave * hi StatusLine ctermbg=Grey
augroup END
