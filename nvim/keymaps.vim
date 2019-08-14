
"" For something esoteric: use chtn (dvorak) cluster for arrows 
""" (it's ijkl on qwerty)
noremap <C-h> h
noremap <C-t> j
noremap <C-c> k
" lost the prev-search
noremap <C-n> l
" I'm never using s command
noremap <C-s> l

map <C-Space> <C-w><C-w>


map  <S-Cr> <Cr>

" c-b as an alias for c-w, window cmds
map  <C-b> <C-w>
map  <C-b><C-b> <C-w><C-w>

" resync colors on f5
map <f5> <Esc>:syn sync fromstart<Cr>
map <S-f5> <Esc>:EnableFastPHPFolds<Cr>
" close buffer leaving splits intact
map <leader>d <Esc>:call CleanDeleteBuffer()<Cr>

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
nnoremap <leader>eo :e ~/.config/openbox/rc.xml<Cr>
nnoremap <leader>em :e ~/.config/openbox/menu.xml<Cr>
nnoremap <leader>ea :e ~/.config/openbox/autostart<Cr>


if has('nvim')
  " deoplete
  " inoremap <silent> <Cr> <C-r>=<SID>deoplete_cr()<Cr>
  " function! s:deoplete_cr()
    " return deoplete#mappings#close_popup() . "\<Cr>"
  " endfunction

  " ncm2

  inoremap <expr> <Cr> (pumvisible() ? "\<c-y>\<Cr>" : "\<Cr>")
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  autocmd BufEnter * call ncm2#enable_for_buffer()
  set completeopt=noinsert,menuone,noselect


  " neosnippet
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " imap <expr><TAB>
  "   \ pumvisible() ? "\<C-n>" :
  "   \ neosnippet#expandable_or_jumpable() ?
  "   \    "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
endif


" Arrow key remapping: Left/Right = indent/unindent
nmap <silent> <Left> <<
nmap <silent> <Right> >>
vmap <silent> <Left> <gv
vmap <silent> <Right> >gv
vmap <silent> < <gv
vmap <silent> > >gv
imap <silent> <Left> <C-d>
imap <silent> <Right> <C-t>


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



map <f10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name") . " ". synIDattr(v:val, "bg#") . "/" . synIDattr(v:val, "fg#")')
endfunc

map <S-F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
