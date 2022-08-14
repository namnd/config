let colors_name = "namnd"
set termguicolors

hi Normal         ctermfg=White      ctermbg=Black      guifg=#FFFFFF   guibg=#000000
hi NonText        ctermfg=DarkGrey                      guifg=#6C6C6C                               gui=none
hi Constant       ctermfg=Grey                          guifg=#A8A8A8
hi Comment        ctermfg=DarkGrey                      guifg=#6C6C6C
hi Todo           ctermfg=Yellow     ctermbg=none       guifg=Yellow                    cterm=bold  gui=bold
hi WarningMsg     ctermfg=Red        ctermbg=none       guifg=Red                       cterm=bold  gui=bold
hi Type           ctermfg=LightGreen                    guifg=#87FFAF                               gui=none
hi PreProc        ctermfg=LightBlue                     guifg=#60D7FF
hi Keyword        ctermfg=Grey                          guifg=#A8A8A8
hi Operator       ctermfg=Grey                          guifg=#A8A8A8

hi Statement      ctermfg=Grey                          guifg=#A8A8A8                               gui=none
hi Identifier     ctermfg=LightBlue                     guifg=#60D7FF                   cterm=none  gui=none
hi Visual         ctermfg=bg         ctermbg=fg         guifg=#000000   guibg=#FFFFFF

hi MatchParen     ctermfg=Magenta    ctermbg=none       guifg=Magenta   guibg=none      cterm=bold  gui=bold
hi Special        ctermfg=DarkCyan                      guifg=#0DCDCD
hi Delimiter      ctermfg=DarkCyan                      guifg=#0DCDCD

hi LineNr         ctermfg=DarkGrey   ctermbg=Black      guifg=#6C6C6C   guibg=#000000
hi CursorLineNr   ctermfg=White                         guifg=#FFFFFF                   cterm=none  gui=none
hi CursorLine                                                           guibg=#000000   cterm=none  gui=none
hi SignColumn                        ctermbg=Black                      guibg=#000000
hi ColorColumn                       ctermbg=DarkGrey                   guibg=#6C6C6C
hi VertSplit      ctermfg=Black      ctermbg=Grey       guifg=#000000   guibg=#A8A8A8
hi QuickFixLine   ctermfg=Magenta                       guifg=Magenta

hi FoldColumn     ctermfg=LightGrey  ctermbg=Black      guifg=#A8A8A8   guibg=#000000
hi Folded                            ctermbg=Black      guibg=#222222

hi DiffAdd        ctermfg=fg         ctermbg=DarkGreen  guifg=fg        guibg=DarkGreen
hi DiffChange     ctermfg=fg         ctermbg=Brown      guifg=fg        guibg=Brown
hi DiffDelete     ctermfg=fg         ctermbg=DarkRed    guifg=fg        guibg=DarkRed

hi GitSignsAdd    ctermfg=DarkGreen                     guifg=DarkGreen
hi GitSignsChange ctermfg=Brown                         guifg=Brown
hi GitSignsDelete ctermfg=DarkRed                       guifg=DarkRed

hi TabLineFill                       ctermbg=DarkGrey                   guibg=#6C6C6C   cterm=none  gui=none
hi TabLineSel     ctermfg=White                        guifg=#FFFFFF                    cterm=none  gui=none
hi TabLine        ctermfg=Black      ctermbg=DarkGrey  guifg=#000000    guibg=#6C6C6C   cterm=none  gui=none

hi Pmenu          ctermfg=Black      ctermbg=DarkGrey  guifg=#000000    guibg=#6C6C6C
hi Directory      ctermfg=Blue                         guifg=#1A8FFF
hi PmenuSel       ctermfg=Black      ctermbg=White     guifg=#000000    guibg=#FFFFFF

hi StatusLine     ctermfg=Black      ctermbg=Grey      guifg=#000000    guibg=#A8A8A8   cterm=none  gui=none
hi StatusLineNC   ctermfg=LightGrey                    guifg=#A8A8A8                    cterm=none  gui=none

hi DiagnosticWarn ctermfg=DarkYellow guifg=DarkYellow
hi DiagnosticFloatingError ctermfg=LightRed guifg=LightRed

hi DapUIBreakpointsCurrentLine ctermfg=Green guifg=Green
hi link DapUIBreakpointsLine DapUIBreakpointsCurrentLine
hi DapUIBreakpointsPath ctermfg=Yellow guifg=Yellow
hi DapUIDecoration ctermfg=Green guifg=Green
hi DapUILineNumber ctermfg=DarkGrey guifg=#6C6C6C
hi DapUIModifiedValue ctermfg=Yellow guifg=Yellow
hi DapUIScope ctermfg=Blue guifg=#1A8FFF
hi DapUISource ctermfg=Yellow guifg=Yellow
hi DapUIStoppedThread ctermfg=Blue guifg=#1A8FFF
hi DapUIThread ctermfg=Blue guifg=#1A8FFF
hi DapUIType ctermfg=DarkGrey guifg=#6C6C6C
hi DapUIValue ctermfg=DarkGrey guifg=#6C6C6C
hi DapUIWatchesHeader ctermfg=Blue guifg=#1A8FFF
hi DapUIWatchesEmpty ctermfg=DarkGrey guifg=#6C6C6C
hi DapUIWatchesValue ctermfg=Green 
hi DapUIWatchesError ctermfg=Red
hi DapBreakpoint ctermfg=3 guifg=Yellow
hi DapStoppedText ctermfg=2 guifg=DarkGreen
hi DapStoppedLine ctermbg=2 ctermfg=0 guifg=Black guibg=DarkGreen
hi DapBreakpointRejected ctermfg=1 guifg=DarkBlue

augroup BgStatusLine
  autocmd!
  au InsertEnter * hi StatusLine ctermbg=White guibg=#FFFFFF
  au InsertLeave * hi StatusLine ctermbg=Grey guibg=#A8A8A8
augroup END
