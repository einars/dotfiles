autocmd BufEnter *.ml,*.c,*.h,*.cpp,*.php :Rooter



autocmd BufRead,BufNewFile * filetype indent off

augroup broken_indents
    autocmd!
    autocmd FileType javascript,yaml,coffee,pug setlocal nosmartindent autoindent ts=8 sts=2 sw=2
augroup END

augroup dumb_huge_tabs
    autocmd!
    autocmd FileType make,c setlocal noexpandtab shiftwidth=8 tabstop=8
augroup END

augroup Haskell
    autocmd!
    autocmd FileType haskell setlocal expandtab shiftwidth=8 tabstop=8
augroup END

augroup latex
    autocmd!
    autocmd FileType tex setlocal shiftwidth=2 softtabstop=2
    let g:tex_flavor = 'latex'
    let g:tex_fold_enable=1
augroup END

augroup sweet_tiny_tabs
    autocmd!
    autocmd FileType ml,ocaml,html setlocal sts=2 ts=2 sw=2 expandtab
augroup END



augroup Python
    autocmd!
    autocmd FileType python setlocal expandtab ts=8 sw=2 sts=2 formatoptions+=croq smartindent
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
        \ keywordprg=pydoc
augroup END

augroup C
    autocmd!
    autocmd FileType c,cpp setlocal nolist tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
augroup END

if has('nvim')
  augroup PHP
      autocmd FileType php setlocal keywordprg=:Phpdoc
  augroup END
else
  augroup PHP
      autocmd FileType php setlocal keywordprg=phpdoc
  augroup END
endif

augroup PHP
    autocmd FileType php setlocal tabstop=4 shiftwidth=4 sts=4
augroup END

augroup ASM
    autocmd FileType asm setlocal syn=avr8bit softtabstop=4 tabstop=4 shiftwidth=4
    autocmd BufReadPost,BufNewFile *.inc setlocal filetype=avr8bit syn=avr8bit
augroup END

augroup Filetypes
  autocmd BufReadPost,BufNewFile *.czz setlocal filetype=scss syn=scss
  autocmd BufReadPost,BufNewFile *.jade setlocal filetype=pug syn=pug
augroup END


augroup Latex
    """ use internal help from bundle/latexhelp
    autocmd!
    autocmd FileType tex setlocal keywordprg=:help
augroup END

augroup Text
    autocmd!
    " autoflow paragrpahs
    autocmd FileType txt setlocal formatoptions +=wa
augroup END

augroup MyPasswords
    autocmd!
    highlight Password ctermfg=252 ctermbg=252 guibg=orange guifg=orange
    autocmd BufReadPost passwords.txt call matchadd('Password', '\v  \zs([^ ]+)\ze( +; .*|$)')
augroup END

augroup Fugitive
    autocmd User fugitive
        \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
        \   nnoremap <buffer> .. :edit %:h<CR> |
        \ endif
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
augroup END

" Soft text limiter
"""autocmd BufRead,BufNew *.* call matchadd('Error', '\%80v.')

" Diff-adds/deletes have a tendency to have nice backgrounds
" Whitespace (ignored) followed by one or multiple TK — TK, TKTKTK etc
autocmd BufRead,BufNew *.* call matchadd('DiffDelete', '\v( )@<=(TK)+')
autocmd BufRead,BufNew *.* call matchadd('DiffAdd', '\v(!!!|///|###|;;;|---) .*$')

""" let's try the autosave on focus lost magic
""" single active window:
" au FocusLost * silent! update
""" all unsaved windows:
autocmd FocusLost * silent! wa


" Don't screw up folds when inserting text that might affect them
" http://stackoverflow.com/questions/5521408/my-vim-and-gvim-are-far-too-slow
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

