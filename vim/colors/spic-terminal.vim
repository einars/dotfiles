" default colors for terminal
hi clear Normal
set bg&
hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "spic-terminal"
if &t_Co < 257
    hi string ctermfg=darkred
    hi comment ctermfg=darkgreen
    hi todo ctermbg=darkred ctermfg=yellow
endif
