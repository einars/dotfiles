" neovim broken map with auto-pairs
autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

"" the shit is slow
"augroup cursorline
"  autocmd!
"  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"  autocmd WinLeave * setlocal nocursorline
"augroup END

augroup PHP
  autocmd!
  autocmd FileType php setlocal keywordprg=:Phpdoc
augroup END


augroup broken_indents
    autocmd!
    " autocmd FileType yaml,coffee,pug setlocal indentexpr= nosmartindent autoindent ts=8 sts=2 sw=2
    autocmd FileType go,golang setlocal noexpandtab ts=8 sts=8 sw=8
    autocmd FileType php setlocal expandtab sts=4 sw=4

augroup END

augroup PHP
  autocmd!
  autocmd FileType php setlocal keywordprg=:Phpdoc
augroup END


augroup Clojure
  autocmd!
  autocmd FileType clojure setlocal showmatch matchtime=1
  " Fireplace, clojure eval
  autocmd FileType clojure nnoremap <buffer> <leader>, <cmd>Eval<cr>
  autocmd FileType clojure nmap <buffer> <leader>. cpp
augroup Clojure

augroup Lisp
  autocmd!
  autocmd FileType lisp setlocal showmatch matchtime=1
  " vlime
  autocmd FileType lisp nnoremap <buffer> <leader>, :call vlime#plugin#SendToREPL(vlime#ui#CurExprOrAtom())<cr>
  autocmd FileType lisp vnoremap <buffer> <leader>, :call vlime#plugin#SendToREPL(vlime#ui#CurExprOrAtom())<cr>
augroup Clojure


""" let's try the autosave on focus lost magic
""" single active window:
" au FocusLost * silent! update
""" all unsaved windows:
augroup FocusLostSave
  autocmd FocusLost * silent! wa
augroup END

augroup Calm
  " calm down colorers: less of the christmas lights in my editor, kthx
  autocmd!
  autocmd ColorScheme * hi! link clojureSpecial clojureFunc
                    \ | hi! link clojureCond clojureFunc
                    \ | hi! link clojureMacro clojureFunc
                    \ | hi! link TSMethod TSKeyword
                    \ | hi! link TSFunction TSKeyword
                    \ | hi! link TSFuncBuiltin TSKeyword
                    \ | hi! link TSConditional TSKeyword
                    \ | hi! link TSConstructor TSKeyword
                    \ | hi! link TSBoolean TSVariable
                    \ | hi! link TSNumber TSVariable
                    \ | hi! link TSFloat TSVariable
                    \ | hi! link TSConstant TSVariable
                    \ | hi! link TSConstBuiltin TSVariable
                    \ | hi! link TSVariableBuiltin TSVariable
                    \ | hi! link TSParameter TSVariable
                    \ | hi! link TSProperty TSVariable
augroup END

augroup z80
  autocmd!
  autocmd FileType asm setlocal sw=16 ts=16
augroup END


augroup Lint
  au! 
  au BufWritePost * lua require('lint').try_lint()
augroup end


au BufRead,BufNewFile *.zig set filetype=zig
