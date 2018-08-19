" source host-specific ginit.$hostname.vim

let hostname = substitute(system('hostname'), '\n', '', '')
let local_init = EditorRoot() . '/ginit.' . hostname . '.vim'
if filereadable(local_init)
  exec 'source ' . local_init
endif

map  <silent>  <S-Insert>  "+p
imap <silent>  <S-Insert>  <Esc>"+pa

