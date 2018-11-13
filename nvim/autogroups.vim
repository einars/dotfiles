autocmd BufEnter *.ml,*.c,*.h,*.cpp,*.php,*.go,*.scala :Rooter

" neovim broken map with auto-pairs
autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

augroup cursorline
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup broken_indents
    autocmd!
    " autocmd FileType yaml,coffee,pug setlocal indentexpr= nosmartindent autoindent ts=8 sts=2 sw=2
    autocmd FileType go,golang setlocal ts=4 sts=4 sw=4
augroup END

augroup latex
    autocmd!
    let g:tex_flavor = 'latex'
    let g:tex_fold_enable=1
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

augroup Filetypes
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
augroup FocusLostSave
  autocmd FocusLost * silent! wa
augroup END

augroup ft_yaml
  autocmd!
  "au Syntax yaml syn region Type start="^table:" end="$" oneline
  au Syntax yaml syn region javaScriptFunction start="^name:" end="$" oneline
augroup END


" Don't screw up folds when inserting text that might affect them
" http://stackoverflow.com/questions/5521408/my-vim-and-gvim-are-far-too-slow
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
"" autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"" autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

