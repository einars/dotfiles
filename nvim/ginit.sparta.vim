function! Dark()
  GuiLinespace 0
  set background=dark
  """ I need dark font to be bolder and larger
  Guifont! Iosevka Term Medium:h11
endfunction

function! Light()
  GuiLinespace 0
  set background=light
  Guifont! Iosevka Term:h10
endfunction

colors nord
Dark


"" inoremap <C-G> <C-r>=Translit('greek')<cr>
"" nnoremap <C-G> :exec Translit('greek')<cr>
