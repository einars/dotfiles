function! Dark()
  GuiLinespace 1
  set background=dark
  colors duskfox
  """ I need dark font to be bolder and larger
  Guifont! Iosevka Term Medium:h12
  " Guifont xos4 Terminus:h10
  "Guifont Fira Mono:h11
  "Guifont Go Mono:h10
endfunction

function! Light()
  GuiLinespace 1
  set background=light
  colors PaperColor
  Guifont! Iosevka Term:h10
endfunction

Light



"" inoremap <C-G> <C-r>=Translit('greek')<cr>
"" nnoremap <C-G> :exec Translit('greek')<cr>
