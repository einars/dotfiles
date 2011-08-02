function! Send_to_Tmux(text)
    let enterized = substitute(a:text, '[\r\n]\+', '\r', 'g')
    call writefile([enterized], "/tmp/tslime.tmp")
    call system("tmux load-buffer /tmp/tslime.tmp" )
    call system("tmux paste-buffer -t 0:0.0")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <C-h><C-h> "ryl:call Send_to_Tmux(@r)<CR>
nmap <C-h><C-h> mt99[(v%<C-h><C-h>`t

