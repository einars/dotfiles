" Vim color file

" Set defaults, but keep any parameters already set by the user
if ! exists("g:zenburn_color_also_Ignore")
    let g:zenburn_color_also_Ignore = 0
endif

if ! exists("g:zenburn_alternate_Error")
    let g:zenburn_alternate_Error = 0
endif

if ! exists("g:zenburn_force_dark_Background")
    let g:zenburn_force_dark_Background = 0
endif

if ! exists("g:zenburn_alternate_Visual")
    let g:zenburn_alternate_Visual = 0
endif

if ! exists("g:zenburn_alternate_Include")
    let g:zenburn_alternate_Include = 0
endif

if ! exists("g:zenburn_unified_CursorColumn")
    let g:zenburn_unified_CursorColumn = 0
endif

if ! exists("g:zenburn_old_Visual")
    let g:zenburn_old_Visual = 0
endif

if ! exists("g:zenburn_disable_ctags_highlighting_support")
    " enabled by default
    let g:zenburn_disable_ctags_highlighting_support = 0
endif

" -----------------------------------------------

hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="zenburn-mine"
set background=dark


" check for ctags-highlighting
if exists("g:loaded_ctags_highlighting") && g:loaded_ctags_highlighting && ! g:zenburn_disable_ctags_highlighting_support
    " internal
    let _zenburn_ctags = 1
endif

hi Boolean         guifg=#dca3a3
hi Character       guifg=#dca3a3 gui=none
hi Comment         guifg=#7f9f7f gui=none
hi Conditional     guifg=#f0dfaf gui=none
hi Constant        guifg=#dca3a3 gui=none
hi Cursor          guifg=#000d18 guibg=#8faf9f gui=none
hi Debug           guifg=#bca3a3 gui=none
hi Define          guifg=#ffcfaf gui=none
hi Delimiter       guifg=#8f8f8f
hi DiffAdd         guifg=#709080 guibg=#313c36 gui=none
hi DiffChange      guibg=#333333
hi DiffDelete      guifg=#333333 guibg=#464646
hi DiffText        guifg=#ecbcbc guibg=#41363c gui=none
hi Directory       guifg=#9fafaf gui=none
hi ErrorMsg        guifg=#80d4aa guibg=#2f2f2f gui=none
hi Exception       guifg=#c3bf9f gui=none
hi Float           guifg=#c0bed1
hi FoldColumn      guifg=#93b3a3 guibg=#3f4040
hi Folded          guifg=#93b3a3 guibg=#3f4040
hi Function        guifg=#efef8f
hi Identifier      guifg=#efdcbc
hi IncSearch       guibg=#f8f893 guifg=#385f38
hi Keyword         guifg=#f0dfaf gui=none
hi Label           guifg=#dfcfaf gui=underline
hi Macro           guifg=#ffcfaf gui=none
hi ModeMsg         guifg=#ffcfaf gui=none
hi MoreMsg         guifg=#ffffff gui=none
hi Number          guifg=#8cd0d3
hi Operator        guifg=#f0efd0
hi PreCondit       guifg=#dfaf8f gui=none
hi PreProc         guifg=#ffcfaf gui=none
hi Question        guifg=#ffffff gui=none
hi Repeat          guifg=#ffd7a7 gui=none
hi Search          guifg=#ffffe0 guibg=#284f28
hi SpecialChar     guifg=#dca3a3 gui=none
hi SpecialComment  guifg=#82a282 gui=none
hi Special         guifg=#cfbfaf
hi SpecialKey      guifg=#9ece9e
hi Statement       guifg=#e3ceab gui=none
hi StatusLine      guifg=#313633 guibg=#ccdc90
hi StatusLineNC    guifg=#2e3330 guibg=#88b090
hi StorageClass    guifg=#c3bf9f gui=none
hi String          guifg=#cc9393
hi Structure       guifg=#efefaf gui=none
hi Tag             guifg=#e89393 gui=none
hi Title           guifg=#efefef gui=none
hi Todo            guifg=#dfdfdf guibg=bg gui=none
hi Typedef         guifg=#dfe4cf gui=none
hi Type            guifg=#dfdfbf gui=none
hi Underlined      guifg=#dcdccc gui=underline
hi VertSplit       guifg=#2e3330 guibg=#688060
hi VisualNOS       guifg=#333333 guibg=#f18c96 gui=none,underline
hi WarningMsg      guifg=#ffffff guibg=#333333 gui=none
hi WildMenu        guibg=#2c302d guifg=#cbecd0 gui=underline

hi SpellBad   guisp=#bc6c4c guifg=#dc8c6c
hi SpellCap   guisp=#6c6c9c guifg=#8c8cbc
hi SpellRare  guisp=#bc6c9c guifg=#bc8cbc
hi SpellLocal guisp=#7cac7c guifg=#9ccc9c

" Entering Kurt zone
if &t_Co > 255
    hi Boolean         ctermfg=181
    hi Character       ctermfg=181   cterm=none
    hi Comment         ctermfg=108
    hi Conditional     ctermfg=223   cterm=none
    hi Constant        ctermfg=181   cterm=none
    hi Cursor          ctermfg=233   ctermbg=109     cterm=none
    hi Debug           ctermfg=181   cterm=none
    hi Define          ctermfg=223   cterm=none
    hi Delimiter       ctermfg=245
    hi DiffAdd         ctermfg=66    ctermbg=237     cterm=none
    hi DiffChange      ctermbg=236
    hi DiffDelete      ctermfg=236   ctermbg=238
    hi DiffText        ctermfg=217   ctermbg=237     cterm=none
    hi Directory       ctermfg=109   cterm=none
    hi ErrorMsg        ctermfg=115   ctermbg=236     cterm=none
    hi Exception       ctermfg=249   cterm=none
    hi Float           ctermfg=251
    hi FoldColumn      ctermfg=109   ctermbg=238
    hi Folded          ctermfg=109   ctermbg=238
    hi Function        ctermfg=228
    hi Identifier      ctermfg=223
    hi IncSearch       ctermbg=228   ctermfg=233
    hi Keyword         ctermfg=223   cterm=none
    hi Label           ctermfg=187   cterm=underline
    hi LineNr          ctermfg=248   ctermbg=233
    hi Macro           ctermfg=223   cterm=none
    hi ModeMsg         ctermfg=223   cterm=none
    hi MoreMsg         ctermfg=15    cterm=none
    hi Number          ctermfg=116
    hi Operator        ctermfg=230
    hi PreCondit       ctermfg=180   cterm=none
    hi PreProc         ctermfg=223   cterm=none
    hi Question        ctermfg=15    cterm=none
    hi Repeat          ctermfg=223   cterm=none
    hi Search          ctermfg=230   ctermbg=233
    hi SpecialChar     ctermfg=181   cterm=none
    hi SpecialComment  ctermfg=108   cterm=none
    hi Special         ctermfg=181
    hi SpecialKey      ctermfg=151
    hi Statement       ctermfg=187   ctermbg=234     cterm=none
    hi StatusLine      ctermfg=236   ctermbg=186
    hi StatusLineNC    ctermfg=235   ctermbg=108
    hi StorageClass    ctermfg=249   cterm=none
    hi String          ctermfg=174
    hi Structure       ctermfg=229   cterm=none
    hi Tag             ctermfg=181   cterm=none
    hi Title           ctermfg=7     ctermbg=234     cterm=none
    hi Todo            ctermfg=108   ctermbg=234     cterm=none
    hi Typedef         ctermfg=253   cterm=none
    hi Type            ctermfg=187   cterm=none
    hi Underlined      ctermfg=188   ctermbg=234     cterm=none
    hi VertSplit       ctermfg=236   ctermbg=65
    hi VisualNOS       ctermfg=236   ctermbg=210     cterm=none
    hi WarningMsg      ctermfg=15    ctermbg=236     cterm=none
    hi WildMenu        ctermbg=236   ctermfg=194     cterm=none

    " spellchecking, always "bright" background
    hi SpellLocal ctermfg=14  ctermbg=237
    hi SpellBad   ctermfg=9   ctermbg=237
    hi SpellCap   ctermfg=12  ctermbg=237
    hi SpellRare  ctermfg=13  ctermbg=237

    " pmenu
    hi PMenu      ctermfg=248  ctermbg=0
    hi PMenuSel   ctermfg=223 ctermbg=235

        hi Normal ctermfg=188 ctermbg=234
        hi NonText         ctermfg=238

        if exists("g:zenburn_color_also_Ignore") && g:zenburn_color_also_Ignore
            hi Ignore          ctermfg=238
        endif

        " hc mode, darker CursorLine, default 236
        hi CursorLine      ctermbg=233   cterm=none

        if exists("g:zenburn_unified_CursorColumn") && g:zenburn_unified_CursorColumn
            hi CursorColumn      ctermbg=233   cterm=none
        else
            hi CursorColumn      ctermbg=235   cterm=none
        endif

    if exists("g:zenburn_alternate_Error") && g:zenburn_alternate_Error
        " use more jumpy Error
        hi Error ctermfg=210 ctermbg=52 gui=none
    else
        " default is something more zenburn-compatible
        hi Error ctermfg=228 ctermbg=95 gui=none
    endif
endif

    " use new darker background
    hi Normal          guifg=#dcdccc guibg=#1f1f1f
    hi CursorLine      guibg=#121212 gui=none
    if exists("g:zenburn_unified_CursorColumn") && g:zenburn_unified_CursorColumn
        hi CursorColumn    guibg=#121212 gui=none
    else
        hi CursorColumn    guibg=#2b2b2b
    endif
    hi Pmenu           guibg=#242424 guifg=#ccccbc
    hi PMenuSel        guibg=#353a37 guifg=#ccdc90 gui=none
    hi PmenuSbar       guibg=#2e3330 guifg=#000000
    hi PMenuThumb      guibg=#a0afa0 guifg=#040404
    hi MatchParen      guifg=#f0f0c0 guibg=#383838 gui=none
    hi SignColumn      guifg=#9fafaf guibg=#181818 gui=none
    hi TabLineFill     guifg=#cfcfaf guibg=#181818 gui=none
    hi TabLineSel      guifg=#efefef guibg=#1c1c1b gui=none
    hi TabLine         guifg=#b6bf98 guibg=#181818 gui=none
    hi NonText         guifg=#404040 gui=none

    hi LineNr          guifg=#9fafaf guibg=#161616

    " high contrast
    "hi Visual        guibg=#304a3d
    "hi VisualNos     guibg=#304a3d
    "TODO no nice greenish in console, 65 is closest. use full black instead,
    "although i like the green..!
    hi Visual        guibg=#0f0f0f
    hi VisualNos     guibg=#0f0f0f
    if &t_Co > 255
        hi Visual ctermbg=0
    endif

if exists("g:zenburn_alternate_Error") && g:zenburn_alternate_Error
    " use more jumpy Error
    hi Error        guifg=#e37170 guibg=#664040 gui=none
else
    " default is something more zenburn-compatible
    hi Error        guifg=#e37170 guibg=#3d3535 gui=none
endif

if exists("g:zenburn_alternate_Include") && g:zenburn_alternate_Include
    " original setting
    hi Include      guifg=#ffcfaf gui=none
else
    " new, less contrasted one
    hi Include      guifg=#dfaf8f gui=none
endif

if exists("g:zenburn_color_also_Ignore") && g:zenburn_color_also_Ignore
    " color the Ignore groups
    " note: if you get strange coloring for your files, turn this off (unlet)
    hi Ignore guifg=#545a4f
endif

" new tabline and fold column
" TODO Align with 256-color
hi FoldColumn    guibg=#161616
hi Folded        guibg=#161616
hi TabLine       guifg=#88b090 guibg=#313633 gui=none
hi TabLineSel    guifg=#ccd990 guibg=#222222
hi TabLineFill   guifg=#88b090 guibg=#313633 gui=none

" hi SpecialKey    guibg=#242424

if &t_Co > 255
    hi FoldColumn    ctermbg=233
    hi Folded        ctermbg=233
    hi TabLine       ctermbg=234 ctermfg=187 cterm=none
    hi TabLineSel    ctermbg=236 ctermfg=229 cterm=none
    hi TabLineFill   ctermbg=233 ctermfg=233
endif

" EXPERIMENTAL ctags_highlighting support
" link/set sensible defaults here;
"
" For now I mostly link to subset of Zenburn colors, the linkage is based
" on appearance, not semantics. In later versions I might define more new colours.
"
" HELP NEEDED to make this work properly.
if exists("_zenburn_ctags") && _zenburn_ctags

        " Highlighter seems to think a lot of things are global variables even
        " though they're not. Example: python method-local variable is
        " coloured as a global variable. They should not be global, since
        " they're not visible outside the method.
        " If this is some very bright colour group then things look bad.
        hi link CTagsGlobalVariable    Identifier

        hi CTagsClass             guifg=#acd0b3
        if &t_Co > 255
            hi CTagsClass         ctermfg=115
        endif

        hi link CTagsImport       Statement
        hi link CTagsMember       Function

        hi link CTagsGlobalConstant    Constant

        " These do not yet have support, I can't get them to appear
        hi link EnumerationValue  Float
        hi link EnumerationName   Identifier
        hi link DefinedName       WarningMsg
        hi link LocalVariable     WarningMsg
        hi link Structure         WarningMsg
        hi link Union             WarningMsg
endif


