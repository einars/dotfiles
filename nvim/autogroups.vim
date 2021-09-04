" neovim broken map with auto-pairs
autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

"" the shit is slow"
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

    autocmd FileType php syn on # use php.vim instead of messy treesitter
augroup END

augroup PHP
  autocmd!
  autocmd FileType php setlocal keywordprg=:Phpdoc
augroup END



""" let's try the autosave on focus lost magic
""" single active window:
" au FocusLost * silent! update
""" all unsaved windows:
augroup FocusLostSave
  autocmd FocusLost * silent! wa
augroup END

au BufRead,BufNewFile *.zig set filetype=zig
