function! Dark()
  GuiLinespace 0
  set background=dark
  """ I need dark font to be bolder and larger
  colors nord
  Guifont! Iosevka Term Medium:h12
endfunction

function! Light()
  GuiLinespace 0
  set background=light
  colors PaperColor
  Guifont! Iosevka Term:h11
endfunction

Dark


"" inoremap <C-G> <C-r>=Translit('greek')<cr>
"" nnoremap <C-G> :exec Translit('greek')<cr>
