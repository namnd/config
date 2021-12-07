hi QuickFixLine ctermbg=black
hi TestOk    ctermfg=green 
hi TestError ctermfg=red

syn match TestOk    "\v(passed|✓)"
syn match TestError "\v(failed|✕)"
