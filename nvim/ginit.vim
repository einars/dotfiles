" source host-specific ginit.$hostname.vim

let hostname = substitute(system('hostname'), '\n', '', '')
let local_init = EditorRoot() . '/ginit.' . hostname . '.vim'
if filereadable(local_init)
  exec 'source ' . local_init
endif

map  <silent>  <S-Insert>  "+p
imap <silent>  <S-Insert>  <Esc>"+pa

set mouse=a

function! s:goyo_enter()
  GuiLinespace 8
  set background=dark
  "colors PaperColor
  Guifont! Go Mono:h16
  set wrap linebreak
endfunction

function! s:goyo_leave()
  Light
  set nowrap nolinebreak
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
