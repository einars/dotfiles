" navigate buffers with ^z and ^c

imap <c-z> <esc>:bp<cr>
imap <c-c> <esc>:bn<cr>
map  <c-z> :bp<cr>
map  <c-c> :bn<cr>
map  <S-CR> <cr>

map <leader>s :call Switch('')<left><left>
" resync colors on f5
map <f5> <esc>:syn sync fromstart<cr>
map <s-f5> <esc>:EnableFastPHPFolds<cr>
" close buffer leaving splits intact
map <leader>d <esc>:call CleanDeleteBuffer()<cr>

" get rid of search highlighting with leader-space
nnoremap <leader><space> :noh<cr>

nnoremap <leader>r :retab<cr>:call StripTrailingWhitespace()<cr>

" ,e - various common editors
nnoremap <leader>ev :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>ez :e ~/.zshrc<cr>
nnoremap <leader>ec :e ~/commands<cr>
nnoremap <leader>eq :e ~/dokumenti/quotes.txt<cr>
nnoremap <leader>en :e ~/dokumenti/notes.txt<cr>
nnoremap <leader>et :e ~/dokumenti/notes-tech.txt<cr>
nnoremap <leader>ed :e ~/dokumenti/drawing.txt<cr>
nnoremap <leader>es :e ~/dokumenti/scribble.txt<cr>
nnoremap <leader>eo :e ~/.config/openbox/rc.xml<cr>
nnoremap <leader>em :e ~/.config/openbox/menu.xml<cr>




""" functions
"
" leader-s: homebrew session switcher
" Hombrew session switcher
" ,s — open switcher
" sessions stored in ~/.vim/sessions
function! Switch(session)
    let dir = EditorRoot() . '/sessions'
    if ! isdirectory(dir) && exists('*mkdir')
        exec mkdir(dir, '', 0700)
    endif
    if (v:this_session != '')
        execute 'mksession!' v:this_session
    endif
    "execute "0,9000bd"
    execute "%bd"
    let n = dir . '/' . a:session . '.ex'
    if ( ! filereadable(n))
        execute 'mksession!' n
    endif
    echom n
    execute 'source' n
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


function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  normal `Z
endfunction

map  <silent>  <S-Insert>  "+p
imap <silent>  <S-Insert>  <Esc>"+pa
