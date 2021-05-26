" let g:loaded_matchparen=1             " die, slow and needless matching paren highlighting

let mapleader=","

if ! has('nvim')
  """ vim stuff
  set ttyfast
  set cryptmethod=blowfish
  set t_md=               " no bold fonts in terminal
  " remove bell
  set noerrorbells novisualbell t_vb=
  if has('gui_running')
    set guioptions+=c       """ use console dialogs
    set guioptions-=T       """ show the toolbar
    set guioptions-=m       """ show the menu
    set guioptions+=r       """ right scrollbar
    set guioptions-=L       """ left scrollbar
    set guioptions-=e       """ tab menu
    " set guifont=xos4\ Terminus\ 10
    set guifont=Iosevka\ Term\ 12
  endif
endif

if has('nvim')
  "set termguicolors
endif

" Disable cursor blinking
set guicursor+=a:blinkon0


set nocursorline
set noundofile
set noshowmatch         " jump to matching paren quickly
set nrformats=hex       " c-a, c-x won't treat 05 as octal
set wildmenu            " filename etc completion on tab
set wildmode=full
set scrolloff=15
set nostartofline
set shiftround          " shift in mod 4
set nojoinspaces        " with joinspaces, two spaces are entered after . / ? / !
set splitright          " split on the correct side
set splitbelow          " split on the correct side
set tabstop=8 shiftwidth=2 softtabstop=0 expandtab smarttab
set smartindent
set wildchar=<Tab>
set laststatus=2        " good statusline is good
" set statusline=%<%f\%h%m%r%=%-20.(%L\ %l:%v\ %)\ \ \%h%m%r%=\%P
"set statusline=%<%f\%h%m%r\ %{fugitive#statusline()}%=%-20.(%L\ %l:%v\ %)\ \ \%h%m%r%=\%P
set statusline=%<%f\%h%m%r\ %=%-20.(%L\ %l:%v\ %)\ \ \%h%m%r%=\%P
set wildignore=*.cmi,*.cmx,*.cmo,*.class,*.pyc,.svn,.git,*.o,*.a,*.so,target,*/.git/*,*/bower_components/*,*/node_modules/*
set suffixes-=.h
set virtualedit=block
set shortmess+=c  " fuck completion message spam


"set nolazyredraw


" no need for backups, swaps, nothing
set backupdir= 
set nobackup
set nowritebackup
set dir=
set noswapfile

set sessionoptions-=options " no settings in session
set sessionoptions-=folds   " no folds in session
set sessionoptions-=winpos  " no need for win pos
set sessionoptions-=winsize " no need for win size
set sessionoptions-=help    " dont care for help windows
set sessionoptions+=curdir  " curdir is important

set clipboard^=unnamed,unnamedplus


"set completeopt=menu,preview,noinsert,noselect
set completeopt=menu

set hidden              " suddenly, magically, buffers get usable
set autoread            " don't care about ext-modified files, just reload them
au FocusGained * :checktime " nvim autoread workaround

" show or hide whitespace warnings
set nolist
set noshowcmd " no need for keystroke echo
" set nolist """ coprogrammers
set listchars=tab:·\ ,trail:.,extends:#,nbsp:▮

set bs=indent,eol,start " usable backspace
set complete-=i
set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrap
set nonumber

function! EditorRoot()
  if has('nvim')
      return expand("~/.config/nvim")
  else
      return expand("~/.vim")
  endif
endfunction

exec 'source ' . EditorRoot() . '/plugins.vim'


if ! has('nvim')
  colors default
else
  colors PaperColor
endif


let g:searchEmptyLinesPostfixing = 3

" open multiple files in current tab
let g:ctrlp_open_multiple_files = '1vir'

let g:ctrlp_user_command = {
        \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files | grep -v bower_components | grep -v build | grep -v "images/" | grep -v "^protected/extensions" | grep -v "^framework/"' ],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
        \ 'fallback': 'find %s -type f'
        \ }





function! Phpdoc(word)
  " let word = expand('<cword>')
  enew!
  exe 'r !phpdoc '.a:word
  setlocal nomod
  setf txt
  normal gg
endfunction

command! -nargs=* Phpdoc call Phpdoc(<f-args>)



exec 'source ' . EditorRoot() . '/passwords.vim'
exec 'source ' . EditorRoot() . '/keymaps.vim'
exec 'source ' . EditorRoot() . '/autogroups.vim'
exec 'source ' . EditorRoot() . '/sessions.vim'

" source host-specific init.$hostname.vim
let hostname = substitute(system('hostname'), '\n', '', '')
let local_init = EditorRoot() . '/init.' . hostname . '.vim'
if filereadable(local_init)
  exec 'source ' . local_init
endif

function! Dark()
  set background=dark
endfunction

function! Light()
  set background=light
endfunction

command! Dark :call Dark()
command! Light :call Light()

Light
