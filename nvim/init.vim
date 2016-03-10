" let g:loaded_matchparen=1             " die, slow and needless matching paren highlighting

let mapleader=","

""" vim stuff
if ! has('nvim')
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
    set guifont=Terminus\ 10
  endif
endif

set nocursorline
set noundofile
set lsp=5
" set cryptmethod=blowfish
set noshowmatch         " jump to matching paren quickly
set nrformats=hex       " c-a, c-x won't treat 05 as octal
set wildmenu            " filename etc completion on tab
set wildmode=full
set scrolloff=15
set nostartofline
set tabstop=8
set softtabstop=2
set shiftwidth=2
set shiftround          " shift in mod 4
set nojoinspaces        " with joinspaces, two spaces are entered after . / ? / !
set splitright          " split on the correct side
set expandtab
set autoindent
set wildchar=<Tab>
set laststatus=2        " good statusline is good
" set statusline=%<%f\%h%m%r%=%-20.(%L\ %l:%v\ %)\ \ \%h%m%r%=\%P
set statusline=%<%f\%h%m%r\ %{fugitive#statusline()}%=%-20.(%L\ %l:%v\ %)\ \ \%h%m%r%=\%P
set wildignore=*.cmi,*.cmx,*.cmo,*.class,*.pyc,.svn,.git,*.o,*.a,*.so,target
set suffixes-=.h
set virtualedit=block
set shortmess+=c  " fuck completion message spam

set mouse= " don't care for specific mouse support, neovim and gvim-qt guis provide enough pizzazz

set backupdir= " no need for backups
set nobackup
set nowritebackup
set dir=       " no need for swap

set sessionoptions-=options " no settings in session
set sessionoptions-=folds   " no folds in session
set sessionoptions-=winpos  " no need for win pos
set sessionoptions-=winsize " no need for win size
set sessionoptions-=help    " dont care for help windows
set sessionoptions+=curdir  " curdir is important


set completeopt=menu,preview,noinsert,noselect

set hidden              " suddenly, magically, buffers get usable
set autoread            " don't care about ext-modified files, just reload them

" show or hide whitespace warnings
set list
" set nolist """ coprogrammers
set listchars=tab:·\ ,trail:.,extends:#,nbsp:▮

set bs=indent,eol,start " usable backspace
set hlsearch
set incsearch
set ignorecase          " search ignores case while no uppercase is searched
set smartcase
set nowrap              " dont' wrap the text
set noswapfile          " can't remember a single time this would have been useful
set nonumber


function! EditorRoot()
  if has('nvim')
      return expand("~/.config/nvim")
  else
      return expand("~/.vim")
  endif
endfunction


filetype off
let &rtp = &rtp . ',' . EditorRoot() . '/bundle/Vundle.vim/'
call vundle#begin(EditorRoot() . '/bundle')

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'spiiph/vim-space'
Plugin 'einars/vim-phpfold'

let g:translit_toggle_keymap = '<S-F1>'
Plugin 'einars/translit.vim'
Plugin 'kien/ctrlp.vim'

Plugin 'digitaltoad/vim-pug'
Plugin 'kchmck/vim-coffee-script'
Plugin 'rgrinberg/vim-ocaml'
Plugin 'derekwyatt/vim-scala'

Plugin 'junegunn/goyo.vim'
Plugin 'stephpy/vim-yaml'

let g:ycm_key_detailed_diagnostics = '<F11>'
Plugin 'Valloric/YouCompleteMe'


call vundle#end()

filetype plugin indent on  " detect filetypes
syntax on                  " colors


let g:searchEmptyLinesPostfixing = 3

let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|\.svn|media|release|node_modules|bower_components)$',
  \ 'file': '\v\.(class|so|o|pyc)$',
  \ }

let g:ctrlp_user_command = {
        \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
        \ 'fallback': 'find %s -type f'
        \ }




" let g:seoul256_background=235
" colors seoul256
colors sorcerer

command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
" let g:Guifont="DejaVu Sans Mono:h13"
let g:Guifont="Terminus:h11"


function! Phpdoc(word)
  " let word = expand('<cword>')
  enew!
  exe 'r !phpdoc '.a:word
  setlocal nomod
  setf txt
  normal gg
endfunction

command! -nargs=* Phpdoc call Phpdoc(<f-args>)



exec 'source ' . EditorRoot() . '/keymaps.vim'
exec 'source ' . EditorRoot() . '/autogroups.vim'
exec 'source ' . EditorRoot() . '/jeetworks-arrows.vim'
