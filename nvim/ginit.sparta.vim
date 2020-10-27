colors miniblergh


function! Dark()
  GuiLinespace 4
  set background=dark
  colors miniblergh
  """ I need dark font to be bolder and larger
  " "Guifont Iosevka Term Medium:h10
  Guifont xos4 Terminus:h10
  "Guifont Fira Mono:h11
  "Guifont Go Mono:h10
endfunction

function! Light()
  GuiLinespace 1
  set background=light
  colors PaperColor
  ""Guifont Iosevka Term:h9
  Guifont Go Mono:h10
  "Guifont xos4 Terminus:h9
endfunction

Dark



" single-file writing mode
function! Large()
  GuiLinespace 4
  set background=light
  colors PaperColor
  Guifont Iosevka Term Medium:h16
endfunction

command! Large :call Large()
command! Write :call Large()


inoremap <C-G> <C-r>=Translit('greek')<cr>
nnoremap <C-G> :exec Translit('greek')<cr>
