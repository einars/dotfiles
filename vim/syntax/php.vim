"
" I scratch my own itches. This is my php syntax file, loosely based on the default php.vim.
"
" Einar Lielmanis, einars@spicausis.lv
"
"
" I don't need much. I don't care about built-in functions, or different colours for numbers,
" or actually nothing much: I need colouring to be able to provide subtle accents and get out of the way.
"
" For the best results, use together with the most excellent phpfolding plugin.
" I guess I will rip it apart somewhen, too.
"
" No configuration options are, or will be, exposed. Write and tweak it for your needs.
"

if exists("b:current_syntax")
  finish
endif

syn sync clear

runtime! syntax/html.vim

syn region phpComment  start="/\*" end="\*/" contained extend
syn match phpComment  /#.\{-}\(?>\|$\)\@=/  contained
syn match phpComment  "//.\{-}\(?>\|$\)\@=" contained

syn region phpFunctionDef matchgroup=phpKeyword start=/function\s/ end=/(/me=s-1 extend oneline contained

" far from the comprehensive list. still, most of what I need

syn keyword phpKeyword if else while for switch elseif return die exit echo print static global private protected public class list each array break continue



syn match phpFunction /\(\h\w*::\)\?\h\w*\s*(/me=e-1 contained display


syn match phpIdentifier /$\h\w*/ contained display
syn match phpIdentifierInString /$\h\w*/ contained display

syn match phpSpecialChar  /\\[abcfnrtyv\\"$]/ contained display
syn match phpSpecialChar  /\\x\x\{2}/ contained display
syn match phpPrintfSpecifier /%[sSdx]/ contained display
syn cluster phpDQStringInside contains=phpIdentifierInString,phpSpecialChar,phpPrintfSpecifier
syn cluster phpSQStringInside contains=phpSpecialChar,phpPrintfSpecifier

syn region phpString matchgroup=phpString start=/"/ skip=/\\./ end=/"/ contains=@phpDQStringInside contained extend keepend
syn region phpString matchgroup=phpString start=/`/ skip=/\\./ end=/`/ contains=@phpDQStringInside contained extend keepend
syn region phpString matchgroup=phpString start=/'/ skip=/\\./ end=/'/ contains=@phpSQStringInside contained extend keepend
syn region phpString matchgroup=phpString start=/<<<\z(\I\i*\)/ end=/^\z1\(;\=$\)\@=/ contains=@phpDQStringInside contained extend keepend

" indenting needs this
syn match phpParent "[({[\]})]" contained transparent display

syn region phpRegion  matchgroup=phpTag start=/<?\(php\)\=/ end=/?>/
    \ contains=phpComment,phpParent,phpKeyword,phpFunction,phpString,phpFunctionDef,phpIdentifier keepend


" region sync is sometimes messy with html.vim

"syn sync match phpRegionSync grouphere phpRegion /^\s*<?\(php\)\=\s*$/
"syn sync match phpRegionSync grouphere NONE /^\s*?>\s*$/
"" this (buggy, as it breaks javascript) line helps nice function folding and other redrawing glitches
"syn sync match phpRegionSync grouphere phpRegion "function\s.*(.*\$"


" or, if we're fast enough, just sync all
syn sync fromstart

syn cluster htmlPreproc add=phpRegion

hi def link phpRegion             Normal
hi def link phpComment            Comment
hi def link phpKeyword            Keyword
hi def link phpFunction           Function
hi def link phpString             String
hi def link phpFunctionDef        Function
hi def link phpIdentifier         Identifier
hi def link phpIdentifierInString Identifier
hi def link phpConstIdentifier    Identifier
hi def link phpSpecialChar        Special
hi def link phpPrintfSpecifier    Special

let b:current_syntax = "php"

" yes, that's really all.
