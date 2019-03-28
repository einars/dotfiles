colors PaperColorPatched


function! Dark()
  GuiLinespace 4
  set background=dark
  colors PaperColorPatched
  """ I need dark font to be bolder and larger
  Guifont Iosevka Term Medium:h10
endfunction

function! Light()
  GuiLinespace 2
  set background=light
  colors PaperColorPatched
  Guifont Iosevka Term Light:h9
  ""Guifont Go Mono:h9
endfunction

Relight
