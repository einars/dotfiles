"
" sips from
" https://github.com/sgraham/sgraham/blob/master/vimfiles/lisp/lisp.vim 

nnoremap <buffer> <silent> ( :call Sexp_Previous()<CR>
nnoremap <buffer> <silent> ) :call Sexp_Next()<CR>
nnoremap <buffer> <silent> { :call Sexp_Previous()<CR>
nnoremap <buffer> <silent> } :call Sexp_Next()<CR>

fun! Sexp_Next()
    let [l, c] = Sexp_get_Next()
    call cursor(l, c)
endfun

fun! Sexp_Previous()
    let [l, c] = Sexp_get_Previous()
    if l == 0 && c == 0
        return
    endif
    call cursor(l, c)
    return
endfun

fun! Sexp_get_Next()
    return searchpos('(', 'nW')
endfun

" return the position of the previous s-exp
fun! Sexp_get_Previous()
    let p = getpos(".")

    " If outside of *any* s-exps, move to the previous s-exp first.
    let [l, c] = searchpairpos('(', '', ')', 'bnW')
    if l == 0 && c == 0
        call searchpos(')', 'Wb')
    endif

    " now, move to the start of this s-exp, wherever it may be.
    let [l, c] = searchpos('(', 'Wnb')

    call setpos(".", p)

    return [l, c]
endfun
