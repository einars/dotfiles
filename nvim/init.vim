set ttimeoutlen=100

let mapleader=","

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

set completeopt-=preview

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
set nobackup            " this is a default, but let's say it explicitly
                        "    (who knows what's in /etc/vimrc)
set nowritebackup       " don't care about vim's backups at all
set noswapfile          " can't remember a single time this would have been useful
set nonumber

filetype plugin indent on  " detect filetypes
syntax on                  " colors


set rtp+=~/.config/nvim/bundle/vundle
call vundle#rc('~/.config/nvim/bundle')

Bundle 'airblade/vim-rooter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'spiiph/vim-space'
Bundle 'einars/vim-phpfold'
Bundle 'kien/ctrlp.vim'

Bundle 'Shougo/deoplete.nvim'

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


function! SetDir(path)
    if ! isdirectory(a:path) && exists('*mkdir')
        exec mkdir(a:path, '', 0700)
    endif
    if isdirectory(a:path)
        exec 'set dir=' . a:path
        exec 'set backupdir=' . a:path
    endif
endfunction


call SetDir($HOME . '/.nvim-swap')

let g:seoul256_background=235
colors seoul256

command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
" let g:Guifont="DejaVu Sans Mono:h13"
let g:Guifont="Terminus:h11"


source ~/.config/nvim/keymaps.vim
source ~/.config/nvim/autogroups.vim
