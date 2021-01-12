let loaded_matchparen = 1 " no need for paren matching

call plug#begin(EditorRoot() . '/plugged')

let g:rooter_manual_only = 1
Plug 'airblade/vim-rooter'

" adds Wipeout command to cleanup buffers
Plug 'artnez/vim-wipeout'

" vim-surround: do not use C-s / C-g s
let g:surround_no_insert_mappings = 1
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-sleuth'

"Plug 'evanleck/vim-svelte', { 'branch': 'main' }
Plug 'leafOfTree/vim-svelte-plugin'

Plug 'sirtaj/vim-openscad'

Plug 'einars/vim-phpfold'
"Plug 'einars/translit.vim'

Plug 'mattn/webapi-vim'

let g:user_emmet_install_global=0
let g:user_emmet_leader_key='<C-F>'
exec 'source ' . EditorRoot() . '/snippets/emmet.vim'
Plug 'mattn/emmet-vim'
autocmd FileType php,html,javascript,javascriptreact EmmetInstall
autocmd FileType css,scss EmmetInstall

Plug 'ctrlpvim/ctrlp.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'sheerun/vim-polyglot'

"let g:lightline = { 'colorscheme': 'seoul256' }
"Plug 'itchyny/lightline.vim'

Plug 'vifm/vifm.vim'
map <Leader>v :Vifm<CR>

Plug 'NLKNguyen/papercolor-theme'
"let g:seoul256_background = 234
"Plug 'junegunn/seoul256.vim' " paper beats seoul
Plug 'dracula/vim'

if has('nvim')
  Plug 'equalsraf/neovim-gui-shim'

  " adjust keymaps.vim manually as well

  "let g:deoplete#enable_at_startup = 1
  "Plug 'Shougo/deoplete.nvim'

  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'

  let g:neosnippet#disable_runtime_snippets = { '_': 1 }
  let g:neosnippet#snippets_directory = EditorRoot() . "/snippets"
  " Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/neosnippet.vim'

  " Plug 'masukomi/vim-markdown-folding'
endif

" the stock one freezes sometime
Plug '2072/PHP-Indenting-for-VIm'

call plug#end()

augroup csssyn
  autocmd!
  autocmd FileType css,scss setlocal iskeyword+=-
augroup end
