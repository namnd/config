function! ToggleQuickFix()
    if getqflist({'winid' : 0}).winid
        cclose
    else
        copen
    endif
endfunction

command! -nargs=0 -bar ToggleQuickFix call ToggleQuickFix()

nnoremap <leader>2 :ToggleQuickFix<CR>
nnoremap <leader>3 :colder<CR>
nnoremap <leader>0 :cnewer<CR>
