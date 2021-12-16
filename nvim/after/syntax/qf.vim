hi  QuickFixLine ctermbg=black
hi  TestOk       ctermfg=green
hi  TestError    ctermfg=red
hi  TestExpected ctermfg=green
hi  TestReceived ctermfg=red
hi  TestFail     ctermbg=red    ctermfg=black
hi  TestPass     ctermbg=green  ctermfg=black

syn match        TestOk        "\v(passed|✓)"
syn match        TestError     "\v(failed|✕)"
syn match        TestFail      "\v(FAIL)"
syn match        TestPass      "\v(PASS)"

syn region TestExpected start=/- Expected/ end=/\n/
syn region TestReceived start=/+ Received/ end=/\n/
