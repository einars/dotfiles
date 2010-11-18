function! Send_to_Tmux(text)
  let escaped_text = substitute(a:text, "'", "'\\\\''", 'g')
  let trimmed_text = substitute(escaped_text, '[\r\n ]\+$', '', 'g')
  call system("tmux set-buffer -t 0 '" . trimmed_text . "\n'" )
  call system("tmux paste-buffer -t 0:0.1")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <C-h><C-h> "ryl:call Send_to_Tmux(@r)<CR>
nmap <C-h><C-h> mt99[(v%<C-h><C-h>`t

