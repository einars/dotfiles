" navigate buffers with ^z and ^c

imap <c-z> <esc>:bp<cr>
imap <c-c> <esc>:bn<cr>
map  <c-z> :bp<cr>
map  <c-c> :bn<cr>
map  <S-CR> <cr>

" c-b as an alias for c-w, window cmds
map  <c-b> <c-w>
map  <c-b><c-b> <c-w><c-w>

" resync colors on f5
map <f5> <esc>:syn sync fromstart<cr>
map <s-f5> <esc>:EnableFastPHPFolds<cr>
" close buffer leaving splits intact
map <leader>d <esc>:call CleanDeleteBuffer()<cr>

nmap ; :

function! CleanDeleteBuffer()
    """ based on CleanClose function, found somewhere
    " just do not save the buffer under no circumstances
    let todelbufNr = bufnr("%")
    let newbufNr = bufnr("#")
    if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
        exe "b".newbufNr
    else
        bnext
    endif

    if (bufnr("%") == todelbufNr)
        new
    endif
    exe "bd!".todelbufNr
endfunction


" get rid of search highlighting with leader-space
nnoremap <leader><space> :noh<cr>

nnoremap <leader>r :retab<cr>:call StripTrailingWhitespace()<cr>

" ,e - various common editors
nnoremap <leader>ev :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>eo :e ~/.config/openbox/rc.xml<cr>
nnoremap <leader>em :e ~/.config/openbox/menu.xml<cr>


if has('nvim')
  " deoplete tab
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return deoplete#mappings#close_popup() . "\<CR>"
  endfunction
endif


" Arrow key remapping: Left/Right = indent/unindent
nmap <silent> <Left> <<
nmap <silent> <Right> >>
vmap <silent> <Left> <gv
vmap <silent> <Right> >gv
vmap <silent> < <gv
vmap <silent> > >gv
imap <silent> <Left> <C-D>
imap <silent> <Right> <C-T>


function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  normal `Z
endfunction

map  <silent>  <S-Insert>  "+p
imap <silent>  <S-Insert>  <Esc>"+pa

function! CleanDeleteBuffer()
    """ based on CleanClose function, found somewhere
    " just do not save the buffer under no circumstances
    let todelbufNr = bufnr("%")
    let newbufNr = bufnr("#")
    if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
        exe "b".newbufNr
    else
        bnext
    endif

    if (bufnr("%") == todelbufNr)
        new
    endif
    exe "bd!".todelbufNr
endfunction


