" superminimal theme with tango-ish colors
"
set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "miniblergh"

" this comes from dracula theme
hi Cursor ctermfg=17 ctermbg=231 cterm=NONE guifg=#282a36 guibg=#f8f8f0 gui=NONE
hi Visual ctermfg=NONE ctermbg=241 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
hi CursorLine ctermbg=234 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
hi CursorColumn ctermbg=234 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#3d3f49 gui=NONE
hi LineNr ctermfg=60 ctermbg=NONE cterm=NONE guifg=#909194 guibg=#282a36 gui=NONE
hi CursorLineNr ctermfg=228 ctermbg=234 cterm=NONE guifg=#f1fa8c guibg=#44475a gui=NONE
hi VertSplit ctermfg=231 ctermbg=236 cterm=NONE guifg=#64666d guibg=#64666d gui=NONE
hi MatchParen ctermfg=212 ctermbg=NONE cterm=underline guifg=#ff79c6 guibg=NONE gui=underline
hi StatusLine ctermfg=231 ctermbg=236 cterm=NONE guifg=#f8f8f2 guibg=#64666d gui=NONE
hi StatusLineNC ctermfg=231 ctermbg=236 cterm=NONE guifg=#f8f8f2 guibg=#64666d gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#44475a gui=NONE
hi IncSearch ctermfg=17 ctermbg=84 cterm=none guifg=#282a36 guibg=#50fa7b gui=none
hi Search ctermfg=17 ctermbg=84 cterm=none guifg=#282a36 guibg=#50fa7b gui=none
hi Directory ctermfg=141 ctermbg=NONE cterm=NONE guifg=#bd93f9 guibg=NONE gui=NONE
hi Folded ctermfg=61 ctermbg=235 cterm=NONE guifg=#6272a4 guibg=#282a36 gui=NONE
hi SignColumn ctermfg=246 ctermbg=235 cterm=NONE guifg=#909194 guibg=#44475a gui=NONE
hi FoldColmun ctermfg=246 ctermbg=235 cterm=NONE guifg=#909194 guibg=#44475a gui=NONE

" the rest of this comes from me and tango palette

""hi Normal guifg=#d3d7cf guibg=#222222
hi Normal guifg=#babdb6 guibg=#222222

""let s:string = 'guifg=#73d216'
""let s:string = 'guifg=#4e9a06 guibg=#193001'
""let s:string_interp = 'guifg=#73d216 guibg=#193001'
let s:string = 'guifg=#4e9a06'
let s:string_interp = 'guifg=#73d216'
let s:identifier = 'guifg=#729fcf'
let s:comment = 'guifg=#f57900'

hi Comment guifg=#f57900
exec 'hi String ' . s:string
hi Todo guibg=#a40000 guifg=#ffffff

exec 'hi jsVariableDef ' . s:identifier
hi link jsDestructuringBlock jsVariableDef
hi link jsDestructuringPropertyValue jsVariableDef
hi link jsClassFuncName jsVariableDef
hi link jsClassDefinition jsVariableDef

hi jsxTagName guifg=#ffffff
hi jsxTag guifg=#ffffff
hi jsxEndTag guifg=#ffffff
hi jsxEndString guifg=#ffffff


hi link javascriptFunction jsVariableDef

exec 'hi phpFunctionDef ' . s:identifier
exec 'hi phpPrintfSpecifier ' . s:string_interp
exec 'hi phpIdentifierInString ' . s:string_interp
""hi phpIdentifier guifg=#eeeeec

exec 'hi scalaNameDefinition ' . s:identifier
exec 'hi scalaInterpolationBrackets ' . s:string
exec 'hi scalaInterpolationBoundary ' . s:string_interp
exec 'hi scalaInterpolationB ' . s:string_interp
exec 'hi scalaInterpolation ' . s:string_interp

exec 'hi scalaInstanceDeclaration ' . s:identifier
exec 'hi scssSelectorName ' . s:identifier
exec 'hi cssTagName ' . s:identifier
exec 'hi cssAttributeSelector ' . s:identifier
exec 'hi cssSelectorOp ' . s:identifier

exec 'hi cssPseudoClass ' . s:identifier
exec 'hi cssNoise ' . s:identifier
exec 'hi cssPseudoClassId ' . s:identifier
exec 'hi cssSelectorOp2 ' . s:identifier

exec 'hi rustFuncName ' . s:identifier
exec 'hi rustCommentLineDoc ' . s:comment

hi link pugJavascriptString clear
hi pugJavascriptString guifg=#ffffff
hi link pugTagInlineText clear
hi link pugTagInlineText String
hi link pugPipedText String
exec 'hi pugClass ' . s:identifier
exec 'hi htmlTagName ' . s:identifier

hi! link Constant Normal
hi! link Character Normal
hi! link Number Normal
hi! link Boolean Normal
hi! link Float Normal
hi! link Identifier Normal
hi! link Function Normal
hi! link Statement Normal
hi! link Conditional Normal
hi! link Repeat Normal
hi! link Label Normal
hi! link Operator Normal
hi! link Keyword Normal
hi! link Exception Normal
hi! link PreProc Normal
hi! link Include Normal
hi! link Define Normal
hi! link Macro Normal
hi! link PreCondit Normal
hi! link Type Normal
hi! link StorageClass Normal
hi! link Structure Normal
hi! link Typedef Normal
hi! link Special Normal
hi! link SpecialChar Normal
hi! link Tag Normal
hi! link Delimiter Normal
hi! link SpecialComment Normal
hi! link Debug Normal
hi! link Error Normal
hi! link Title Normal
hi! link Global Normal
