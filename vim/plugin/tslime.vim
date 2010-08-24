function! Send_to_Tmux(text)
  call system("tmux set-buffer -t 0 '" . substitute(a:text, "'", "'\\\\''", 'g') . "'" )
  call system("tmux paste-buffer -t 0:0.1")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <C-h><C-h> "ry :call Send_to_Tmux(@r)<CR>
nmap <C-h><C-h> vip<C-h><C-h>
nmap <C-h><C-h> mt99[(v% <C-h><C-h>`t
