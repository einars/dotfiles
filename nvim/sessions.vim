"
" leader-s: homebrew session switcher
"
" sessions stored in ~/.vim/sessions
"

map <leader>s :call Switch('')<left><left>

function! Switch(session)
    let dir = EditorRoot() . '/sessions'
    if ! isdirectory(dir) && exists('*mkdir')
        exec mkdir(dir, '', 0700)
    endif
    if (v:this_session != '')
        execute 'mksession!' v:this_session
    endif
    "execute "0,9000bd"
    execute "%bd"
    let n = dir . '/' . a:session . '.ex'
    if ( ! filereadable(n))
        execute 'mksession!' n
    endif
    echom n
    execute 'source' n
endfunction

