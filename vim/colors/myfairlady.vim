"
" myfairlady dark and minimal color scheme
"
" Written by Einar Lielmanis, einar@spicausis.lv
"
" Work in progress
"

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="myfairlady"
set background=dark

" rgb, 256-c
let s:black  ="#000000, 0"
let s:background  ="#222222, 234"
let s:background_search  ="#d7ff00, 190"
let s:background_selection  ="#444444, 238"

let s:normal      ="#87afaf, 109"  " blue
let s:lighter     ="#87af87, 109" " blue (different for gui)
let s:red    ="#af0000, 124"
let s:string    = s:red
let s:instring      ="#d70000, 160"
let s:orange      ="#ff5f00, 202"
let s:irrelevant  ="#585858, none"
let s:background_inv  ="#3a3a3a, 237"
let s:white  ="#ffffff, 251"
let s:green  ="#00875f, 29"

let s:bg_added  ="#005f00, 28"
let s:bg_removed  ="#5f0000, 52"

function! s:hiset(mode, bg, fg)
    let s:cmd = "hi " . a:mode . " gui=none term=NONE"
    if a:bg != "none"
        let s:bg = split(a:bg, '\v[, ]+')
        let s:cmd = s:cmd . " guibg=" . s:bg[0] . " ctermbg=" . s:bg[1]
    endif
    if a:fg != "none"
        let s:fg = split(a:fg, '\v[, ]+')
        let s:cmd = s:cmd . " guifg=" . s:fg[0] . " ctermfg=" . s:fg[1]
    endif
    exec (':' . s:cmd)
endfunction

call s:hiset("Normal", s:background, s:normal)
call s:hiset("Statement", s:background, s:normal)
 call s:hiset("Constant", s:background, s:normal)
call s:hiset("PreProc", s:background, s:normal)
call s:hiset("Type", s:background, s:normal)
call s:hiset("String", s:background, s:string)
call s:hiset("Character", s:background, s:string)
call s:hiset("Keyword", s:background, s:normal)
call s:hiset("Identifier", s:background, s:lighter)
call s:hiset("FunctionName", s:background, s:orange)

call s:hiset("phpCrapsticle", s:background, s:irrelevant)
call s:hiset("phpParent", s:background, s:irrelevant)
call s:hiset("Comment", s:background, s:green)

call s:hiset("Folded", s:background_inv, s:white)

call s:hiset("StatusLine", s:background_inv, s:white)
call s:hiset("StatusLineNC", s:background_inv, s:white)

call s:hiset("IncSearch", s:background_search, s:normal)
call s:hiset("Search", s:background_search, s:normal)
call s:hiset("Visual", s:background_inv, "none")
call s:hiset("VisualNOS", s:background_inv, s:normal)

" call s:hiset("SpecialKey", s:background, s:irrelevant)
call s:hiset("SpecialChar", s:background, s:instring)
call s:hiset("Special", s:background, s:irrelevant)

call s:hiset("diffAdded",    "none", s:green)
call s:hiset("DiffDelete",    "none", s:red)
call s:hiset("diffRemoved",    "none", s:red)

call s:hiset("diffLine",    "none", s:white)
call s:hiset("diffFile",    "none", s:white)

"call s:hiset("DiffChange", s:background,  s:normal)

" others mapped to default, will add as needed
" call s:hiset("Conditional", s:background, s:normal)
" call s:hiset("Debug", s:background, s:normal)
" call s:hiset("Define", s:background, s:normal)
" call s:hiset("Delimiter", s:background, s:normal)


"call s:hiset("Directory", s:background, s:normal)
"call s:hiset("ErrorMsg", s:background, s:normal)
"call s:hiset("Exception", s:background, s:normal)
"call s:hiset("Float", s:background, s:normal)
"call s:hiset("FoldColumn", s:background, s:normal)
"call s:hiset("Keyword", s:background, s:normal)
"call s:hiset("Label", s:background, s:normal)
"call s:hiset("Macro", s:background, s:normal)
"call s:hiset("ModeMsg", s:background, s:normal)
"call s:hiset("MoreMsg", s:background, s:normal)
"call s:hiset("Number", s:background, s:normal)
"call s:hiset("Operator", s:background, s:normal)
"call s:hiset("PreCondit", s:background, s:normal)
"call s:hiset("Question", s:background, s:normal)
"call s:hiset("Repeat", s:background, s:normal)
"call s:hiset("SpecialComment", s:background, s:normal)
"call s:hiset("StorageClass", s:background, s:normal)
"call s:hiset("Structure", s:background, s:normal)
"call s:hiset("Tag", s:background, s:normal)
"call s:hiset("Title", s:background, s:normal)
"call s:hiset("Todo", s:background, s:normal)
"call s:hiset("Typedef", s:background, s:normal)
"call s:hiset("Underlined", s:background, s:normal)
"call s:hiset("VertSplit", s:background, s:normal)
"call s:hiset("WarningMsg", s:background, s:normal)
"call s:hiset("WildMenu", s:background, s:normal)
"
