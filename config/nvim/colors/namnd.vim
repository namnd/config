let colors_name = "namnd"
set termguicolors

fun! <sid>hi(group, fg, bg, attr)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
  endif
  if a:attr != ""
    exec "hi " . a:group . " cterm=" . a:attr . " gui=" . a:attr
  endif
endfun

let s:white = { 'cterm': 'White', 'gui': '#FFFFFF' }
let s:black = { 'cterm': 'Black', 'gui': '#000000' }
let s:darkGrey = { 'cterm': 'DarkGrey', 'gui': '#6C6C6C' }
let s:grey = { 'cterm': 'Grey', 'gui': '#A8A8A8' }
let s:lightGrey = { 'cterm': 'LightGrey', 'gui': '#DDDDDD' }
let s:lightGreen = { 'cterm': 'LightGreen', 'gui': '#87FFAF' }
let s:lightBlue = { 'cterm': 'LightBlue', 'gui': '#60D7FF' }
let s:darkCyan = { 'cterm': 'DarkCyan', 'gui': '#0DCDCD' }
let s:blue = { 'cterm': 'Blue', 'gui': '#1A8FFF' }
let s:darkGreen = { 'cterm': 'DarkGreen', 'gui': '#1C4428' }
let s:brown = { 'cterm': 'Brown', 'gui': '#AF5F00' }
let s:darkRed = { 'cterm': 'DarkRed', 'gui': '#542426' }
let s:darkYellow = { 'cterm': 'DarkYellow', 'gui': 'DarkYellow' }


call <sid>hi('Normal', s:white, s:black, 'none')
call <sid>hi('Visual', s:black, s:white, 'none')
call <sid>hi('CursorLine', {}, s:black, 'none')
call <sid>hi('CursorLineNr', s:white, {}, 'none')
call <sid>hi('SignColumn', {}, s:black, 'none')
call <sid>hi('Folded', {}, {'cterm': 'Black', 'gui': '#222222'}, 'none')

call <sid>hi('TabLineSel', s:white, {}, 'none')
call <sid>hi('TabLineFill', {}, s:darkGrey, 'none')
call <sid>hi('TabLine', s:black, s:darkGrey, 'none')
call <sid>hi('Pmenu', s:black, s:darkGrey, 'none')
call <sid>hi('PmenuSel', s:black, s:white, 'none')
call <sid>hi('FoldColumn', s:lightGrey, s:black, 'none')
call <sid>hi('VertSplit', s:grey, s:black, 'none')
call <sid>hi('LineNr', s:darkGrey, s:black, 'none')
call <sid>hi('ColorColumn', {}, s:darkGrey, 'none')
call <sid>hi('NonText', s:darkGrey, {}, 'none')
call <sid>hi('Comment', s:darkGrey, {}, 'none')
call <sid>hi('Constant', s:grey, {}, 'none')
call <sid>hi('Keyword', s:grey, {}, 'none')
call <sid>hi('Operator', s:grey, {}, 'none')
call <sid>hi('Statement', s:grey, {}, 'none')
call <sid>hi('StatusLine', s:black, s:grey, 'none')
call <sid>hi('StatusLineNC', s:lightGrey, {}, 'none')

call <sid>hi('Type', s:lightGreen, {}, 'none')
call <sid>hi('PreProc', s:lightBlue, {}, 'none')
call <sid>hi('Identifier', s:lightBlue, {}, 'none')
call <sid>hi('Special', s:darkCyan, {}, 'none')
call <sid>hi('Delimiter', s:darkCyan, {}, 'none')
call <sid>hi('Directory', s:blue, {}, 'none')

call <sid>hi('DiffAdd', s:white, s:darkGreen, 'none')
call <sid>hi('DiffChange', s:white, {'cterm': 'DarkGreen', 'gui': '#12261E'}, 'none')
call <sid>hi('DiffDelete', s:lightGrey, s:darkRed, 'none')
call <sid>hi('DiffText', s:white, s:brown, 'none')
call <sid>hi('GitSignsAdd', s:darkGreen, {}, 'bold')
call <sid>hi('GitSignsChange', s:brown, {}, 'bold')
call <sid>hi('GitSignsDelete', s:darkRed, {}, 'bold')
call <sid>hi('Todo', s:black, s:darkYellow, 'bold')
call <sid>hi('WarningMsg', s:darkRed, s:black, 'bold')

hi MatchParen     ctermfg=Magenta    ctermbg=none       guifg=Magenta   guibg=none      cterm=bold  gui=bold
hi QuickFixLine   ctermfg=Magenta                       guifg=Magenta

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
hi DaapStoppedLine ctermbg=2 ctermfg=0 guifg=Black guibg=DarkGreen
hi DapBreakpointRejected ctermfg=1 guifg=DarkBlue

augroup BgStatusLine
  autocmd!
  au InsertEnter * hi StatusLine ctermbg=White guibg=#FFFFFF
  au InsertLeave * hi StatusLine ctermbg=Grey guibg=#A8A8A8
augroup END

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:black s:white s:darkGrey s:grey s:lightGrey 
unlet s:lightGreen s:lightBlue s:darkCyan s:blue s:darkGreen s:brown s:darkRed
