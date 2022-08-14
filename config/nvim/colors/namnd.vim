let colors_name = "namnd"

hi Normal         ctermfg=White      ctermbg=Black
hi NonText        ctermfg=DarkGrey
hi Constant       ctermfg=Grey
hi Comment        ctermfg=DarkGrey                    cterm=italic
hi Todo           ctermfg=Yellow     ctermbg=none     cterm=bold
hi WarningMsg     ctermfg=Red        ctermbg=none     cterm=bold
hi Type           ctermfg=LightGreen
hi PreProc        ctermfg=LightBlue
hi Keyword        ctermfg=Grey
hi Operator       ctermfg=Grey

hi Statement      ctermfg=Grey
hi Identifier     ctermfg=LightBlue                   cterm=none
hi Visual         ctermfg=bg         ctermbg=fg

hi MatchParen     ctermfg=Magenta    ctermbg=none     cterm=bold
hi Special        ctermfg=DarkCyan
hi Delimiter      ctermfg=DarkCyan

hi LineNr         ctermfg=DarkGrey   ctermbg=Black
hi CursorLineNr   ctermfg=White                       cterm=none
hi CursorLine                                         cterm=none
hi SignColumn                        ctermbg=Black
hi ColorColumn                       ctermbg=DarkGrey
hi VertSplit      ctermfg=Black      ctermbg=Grey
hi QuickFixLine   ctermfg=Magenta

hi FoldColumn     ctermfg=LightGrey  ctermbg=Black
hi Folded                            ctermbg=Black

hi DiffAdd        ctermfg=fg         ctermbg=DarkGreen
hi DiffChange     ctermfg=fg         ctermbg=Brown
hi DiffDelete     ctermfg=fg         ctermbg=DarkRed

hi GitSignsAdd    ctermfg=DarkGreen
hi GitSignsChange ctermfg=Brown
hi GitSignsDelete ctermfg=DarkRed

hi TabLineFill                       ctermbg=DarkGrey  cterm=none
hi TabLineSel     ctermfg=White                        cterm=none
hi TabLine        ctermfg=Black      ctermbg=DarkGrey  cterm=none

hi Pmenu          ctermfg=Black      ctermbg=DarkGrey
hi Directory      ctermfg=Blue
hi PmenuSel       ctermfg=Black      ctermbg=White

hi StatusLine     ctermfg=Black      ctermbg=Grey      cterm=none  term=bold,reverse
hi StatusLineNC   ctermfg=LightGrey                    cterm=none  term=none

hi DiagnosticWarn ctermfg=DarkYellow
hi DiagnosticFloatingError ctermfg=LightRed

hi DapUIBreakpointsCurrentLine ctermfg=Green
hi link DapUIBreakpointsLine DapUIBreakpointsCurrentLine
hi DapUIBreakpointsPath ctermfg=Yellow
hi DapUIDecoration ctermfg=Green
hi DapUILineNumber ctermfg=DarkGrey
hi DapUIModifiedValue ctermfg=Yellow
hi DapUIScope ctermfg=Blue
hi DapUISource ctermfg=Yellow
hi DapUIStoppedThread ctermfg=Blue
hi DapUIThread ctermfg=Blue
hi DapUIType ctermfg=DarkGrey
hi DapUIValue ctermfg=DarkGrey
hi DapUIWatchesHeader ctermfg=Blue
hi DapUIWatchesEmpty ctermfg=DarkGrey
hi DapUIWatchesValue ctermfg=Green
hi DapUIWatchesError ctermfg=Red
hi DapBreakpoint ctermfg=3
hi DapStoppedText ctermfg=2
hi DapStoppedLine ctermbg=2 ctermfg=0
hi DapBreakpointRejected ctermfg=1

augroup BgStatusLine
  autocmd!
  au InsertEnter * hi StatusLine ctermbg=White
  au InsertLeave * hi StatusLine ctermbg=Grey
augroup END
