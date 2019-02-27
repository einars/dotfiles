colors PaperColorPatched

GuiLinespace 4

function! Dark()
  set background=dark
  colors PaperColorPatched
  Guifont xos4 Terminus:h9
endfunction

function! Light()
  set background=light
  colors PaperColorPatched
  "Guifont Iosevka Term:h10
  Guifont Go Mono:h9
endfunction

Relight
