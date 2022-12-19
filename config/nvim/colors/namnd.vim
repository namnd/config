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
let s:grey = { 'cterm': 'Grey', 'gui': '#A8A8A8' }
let s:lightGrey = { 'cterm': 'LightGrey', 'gui': '#DDDDDD' }
let s:darkGrey = { 'cterm': 'DarkGrey', 'gui': '#6C6C6C' }
let s:superDarkGrey = { 'cterm': 'DarkGrey', 'gui': '#222222' }
let s:green = { 'cterm': 'Green', 'gui': 'Green' }
let s:darkGreen = { 'cterm': 'DarkGreen', 'gui': '#1C4428' }
let s:lightGreen = { 'cterm': 'LightGreen', 'gui': '#87FFAF' }
let s:blue = { 'cterm': 'Blue', 'gui': '#1A8FFF' }
let s:darkCyan = { 'cterm': 'DarkCyan', 'gui': '#0DCDCD' }
let s:red = { 'cterm': 'Red', 'gui': 'Red' }
let s:darkRed = { 'cterm': 'DarkRed', 'gui': '#542426' }
let s:darkYellow = { 'cterm': 'DarkYellow', 'gui': 'DarkYellow' }
let s:brown = { 'cterm': 'Brown', 'gui': '#AF5F00' }
let s:magenta = { 'cterm': 'Magenta', 'gui': 'Magenta' }
let s:lightBlue = { 'cterm': 'LightBlue', 'gui': '#60D7FF' }

call <sid>hi('Normal', s:white, s:black, 'none')
call <sid>hi('Visual', s:black, s:white, 'none')
call <sid>hi('CursorLine',  {}, s:superDarkGrey, 'none')
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
call <sid>hi('ColorColumn', {}, s:superDarkGrey, 'none')
call <sid>hi('NonText', s:darkGrey, {}, 'none')
call <sid>hi('Comment', s:darkGrey, {}, 'italic')
call <sid>hi('Constant', s:grey, {}, 'none')
call <sid>hi('Keyword', s:grey, {}, 'none')
call <sid>hi('Operator', s:grey, {}, 'none')
call <sid>hi('Statement', s:grey, {}, 'none')
call <sid>hi('StatusLine', s:grey, s:superDarkGrey, 'none')
call <sid>hi('WinBar', s:magenta, s:superDarkGrey, 'none')
call <sid>hi('WinBarNC', s:grey, s:superDarkGrey, 'none')

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
call <sid>hi('GitSignsAdd', s:green, {}, 'bold')
call <sid>hi('GitSignsChange', s:brown, {}, 'bold')
call <sid>hi('GitSignsDelete', s:red, {}, 'bold')
call <sid>hi('Todo', s:black, s:darkYellow, 'bold')
call <sid>hi('WarningMsg', s:darkRed, s:black, 'bold')

call <sid>hi('MatchParen', s:magenta, {}, 'bold')
call <sid>hi('QuickFixLine', s:magenta, {}, 'none')

call <sid>hi('DiagnosticWarn', s:darkYellow, {}, 'none')
call <sid>hi('DiagnosticHint', s:darkGrey, {}, 'none')
call <sid>hi('DiagnosticFloatingError', s:white, {}, 'none')
call <sid>hi('DiagnosticFloatingHint', s:white, {}, 'none')

call <sid>hi('DapBreakpoint', s:darkYellow, {}, 'none')
call <sid>hi('DapStoppedText', s:green, {}, 'none')
call <sid>hi('DapStoppedLine', s:white, s:green, 'none')
call <sid>hi('DapBreakpointRejected', s:red, {}, 'none')
call <sid>hi('DapUIType', s:darkGrey, {}, 'none')
call <sid>hi('DapUIValue', s:darkGrey, {}, 'none')
call <sid>hi('DapUILineNumber', s:darkGrey, {}, 'none')
call <sid>hi('DapUIWatchesEmpty', s:darkGrey, {}, 'none')
call <sid>hi('DapUIWatchesHeader', s:blue, {}, 'none')
call <sid>hi('DapUIWatchesValue', s:green, {}, 'none')
call <sid>hi('DapUIWatchesError', s:red, {}, 'none')
call <sid>hi('DapUIScope', s:blue, {}, 'none')
call <sid>hi('DapUIThread', s:blue, {}, 'none')
call <sid>hi('DapUIStoppedThread', s:blue, {}, 'none')
call <sid>hi('DapUISource', s:darkYellow, {}, 'none')
call <sid>hi('DapUIModifiedValue', s:darkYellow, {}, 'none')
call <sid>hi('DapUIBreakpointsPath', s:darkYellow, {}, 'none')
call <sid>hi('DapUIDecoration', s:green, {}, 'none')
call <sid>hi('DapUIBreakpointsLine', s:green, {}, 'none')
call <sid>hi('DapUIBreakpointsCurrentLine', s:green, {}, 'none')

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:white s:black s:grey s:lightGrey s:darkGrey s:green s:darkGreen s:lightGreen
unlet s:blue s:darkCyan s:red s:darkRed s:darkYellow s:brown s:magenta s:lightBlue
unlet s:superDarkGrey

augroup ColorColumnHighlight
  autocmd!
  autocmd WinEnter * set colorcolumn=81 cursorline
  autocmd WinLeave * set colorcolumn=0 nocursorline
augroup END
