noremap <C-z> <nop>

" I'm never using s command
noremap <C-s> l

map <C-Space> <C-w><C-w>


map  <S-Cr> <Cr>

" c-b as an alias for c-w, window cmds
map  <C-b> <C-w>
map  <C-b><C-b> <C-w><C-w>

" resync colors on f5
map <S-f5> <Esc>:EnableFastPHPFolds<Cr>
" close buffer leaving splits intact
map <leader>d <Esc>:call CleanDeleteBuffer()<Cr>
 
" write + close buffer
nmap <leader>h :w\|bd<Cr>

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
nnoremap <leader><Space> :noh<Cr>

nnoremap <leader>r :retab<Cr>:call StripTrailingWhitespace()<Cr>

" ,e - various common editors
nnoremap <leader>ev :e ~/.config/nvim/init.vim<Cr>
nnoremap <leader>ep :e ~/.config/nvim/plugins.vim<Cr>
nnoremap <leader>es :e ~/.config/sway/config<Cr>
nnoremap <leader>em :e ~/.config/mpv/config<Cr>
nnoremap <leader>ei :e ~/.config/mpv/input.conf<Cr>


" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" Arrow key remapping: Left/Right = indent/unindent
vmap <silent> <Left> <gv
vmap <silent> <Right> >gv
vmap <silent> < <gv
vmap <silent> > >gv


function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  normal `Z
endfunction

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



nnoremap <F10> :TSHighlightCapturesUnderCursor<cr>
