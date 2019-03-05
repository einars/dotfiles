colors PaperColorPatched


function! Dark()
  GuiLinespace 4
  set background=dark
  colors PaperColorPatched
  ""Guifont xos4 Terminus:h9
  ""Guifont Iosevka Term:h10
  Guifont Fira Code:h10
endfunction

function! Light()
  GuiLinespace 2
  set background=light
  colors PaperColorPatched
  Guifont Iosevka Term:h10
  ""Guifont Go Mono:h9
endfunction

Relight
