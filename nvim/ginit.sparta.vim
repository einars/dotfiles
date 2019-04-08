colors PaperColorPatched


function! Dark()
  GuiLinespace 4
  set background=dark
  colors PaperColorPatched
  """ I need dark font to be bolder and larger
  " "Guifont Iosevka Term Medium:h10
  Guifont xos4 Terminus:h9
endfunction

function! Light()
  GuiLinespace 1
  set background=light
  colors PaperColorPatched
  ""Guifont Iosevka Term:h9
  ""Guifont Go Mono:h9
  Guifont xos4 Terminus:h9
endfunction

Relight
