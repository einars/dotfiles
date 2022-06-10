function! Dark()
  GuiLinespace 1
  set background=dark
  """ I need dark font to be bolder and larger
  Guifont! Iosevka Term Medium:h12
endfunction

function! Light()
  GuiLinespace 1
  set background=light
  Guifont! Iosevka Term:h10
endfunction

Light


"" inoremap <C-G> <C-r>=Translit('greek')<cr>
"" nnoremap <C-G> :exec Translit('greek')<cr>
