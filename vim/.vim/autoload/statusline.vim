function! statusline#git()
    let l:branchname = fugitive#head()
    return strlen(l:branchname) > 0 ? '('.l:branchname.')' : ''
endfunction
function! statusline#classname()
    let l:classnameLine = getline(search('\v^[[:alpha:]$_]', "bn", 1, 100))
    if stridx(l:classnameLine, "class") > -1
        let l:parts = split(l:classnameLine)
        let l:classIndex = index(l:parts, 'class')
        " python class
        try
            let l:classname = substitute(l:parts[l:classIndex + 1], ':', '', '')
            return strlen(l:classname) > 0 ? '> '.l:classname : ''
        catch
        endtry
    endif
    return ''
endfunction

function! statusline#filepath() abort
    let l:basename = expand('%:h')
    if l:basename == '' || l:basename == '.'
        return ''
    else
        return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
    endif
endfunction

function! statusline#fileencoding() abort
    let l:encoding = &fileencoding?&fileencoding:&encoding
    if strlen(l:encoding) && l:encoding !=# 'utf-8'
        return l:encoding
    endif
    return ''
endfunction

function! statusline#filetype() abort
    let l:ext = expand('%:e')
    if strlen(l:ext)
        return l:ext
    endif
    return &ft
endfunction
