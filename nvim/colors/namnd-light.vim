let colors_name = "namnd-white"

set background=light

hi Normal         ctermfg=Black         ctermbg=White
hi NonText        ctermfg=LightGrey
hi Constant       ctermfg=DarkGrey
hi Comment        ctermfg=DarkGrey      cterm=italic
hi Todo           ctermfg=Red           cterm=bold     ctermbg=none
hi WarningMsg     ctermfg=Red           cterm=bold     ctermbg=none
hi Type           ctermfg=Brown
hi Directory      ctermfg=DarkBlue
hi PreProc        ctermfg=DarkBlue
hi Keyword        ctermfg=DarkGrey
hi Operator       ctermfg=DarkGrey
hi Conditional    ctermfg=Grey

hi Statement      ctermfg=Grey
hi Identifier     cterm=none            ctermfg=DarkBlue
hi Visual         ctermfg=bg            ctermbg=fg

hi MatchParen     ctermbg=none          ctermfg=Magenta  cterm=bold
hi Special        ctermfg=DarkRed
hi Delimiter      ctermfg=DarkBlue

hi LineNr         ctermbg=White         ctermfg=Grey
hi CursorLineNr   cterm=none            ctermfg=Black
hi CursorLine     cterm=none
hi SignColumn     ctermbg=White
hi ColorColumn    ctermbg=LightGrey
hi VertSplit      ctermbg=DarkGrey      ctermfg=White
hi QuickFixLine   ctermfg=White

hi FoldColumn     ctermbg=White         ctermfg=Grey
hi Folded         ctermbg=LightGrey     ctermfg=Black

hi StatusLine     term=bold,reverse     ctermbg=Grey ctermfg=White cterm=none
hi StatusLineNC   term=none             cterm=none   ctermfg=Grey

hi TabLineFill    cterm=none         ctermbg=DarkGrey
hi TabLineSel     cterm=none         ctermfg=Black
hi TabLine        cterm=none         ctermbg=DarkGrey ctermfg=White

hi Pmenu          ctermfg=0          ctermbg=Grey
hi Directory      ctermfg=Blue
hi PmenuSel       ctermfg=White      ctermbg=Black

hi DiffAdd        ctermbg=LightGreen  ctermfg=fg
hi DiffChange     ctermbg=Yellow      ctermfg=fg
hi DiffDelete     ctermbg=LightRed    ctermfg=fg
hi DiffText       ctermbg=Brown       ctermfg=White

hi GitSignsAdd    ctermfg=DarkGreen
hi GitSignsChange ctermfg=Brown
hi GitSignsDelete ctermfg=DarkRed

hi DapUIBreakpointsCurrentLine ctermfg=DarkGreen
hi link DapUIBreakpointsLine DapUIBreakpointsCurrentLine
hi DapUIBreakpointsPath ctermfg=Brown
hi DapUIDecoration ctermfg=DarkGreen
hi DapUILineNumber ctermfg=DarkGrey
hi DapUIModifiedValue ctermfg=Brown
hi DapUIScope ctermfg=Blue
hi DapUISource ctermfg=Brown
hi DapUIStoppedThread ctermfg=DarkBlue
hi DapUIThread ctermfg=DarkBlue
hi DapUIType ctermfg=DarkGrey
hi DapUIValue ctermfg=DarkGrey
hi DapUIWatchesHeader ctermfg=DarkBlue
hi DapUIWatchesEmpty ctermfg=DarkGrey
hi DapUIWatchesValue ctermfg=DarkGreen
hi DapUIWatchesError ctermfg=DarkRed
hi DapBreakpoint ctermfg=Red
hi DapStoppedText ctermfg=2
hi DapStoppedLine ctermbg=Green ctermfg=Black
hi DapBreakpointRejected ctermfg=Red


augroup BgStatusLine
  autocmd!
  au InsertEnter * hi StatusLine ctermbg=Black
  au InsertLeave * hi StatusLine ctermbg=Grey
augroup END
