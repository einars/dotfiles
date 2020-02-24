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

Plug 'einars/vim-phpfold'

let g:translit_toggle_keymap = '<S-F1>'
Plug 'einars/translit.vim'

let g:user_emmet_install_global=0
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {  'javascript' : { 'extends' : 'jsx' }}
Plug 'mattn/emmet-vim'
autocmd FileType php,html,javascript,javascriptreact EmmetInstall
autocmd FileType css,scss EmmetInstall

Plug 'ctrlpvim/ctrlp.vim'

Plug 'carmonw/elm-vim'

Plug 'digitaltoad/vim-pug'

Plug 'rgrinberg/vim-ocaml'

Plug 'derekwyatt/vim-scala'
Plug 'dag/vim-fish'

"Plug 'stephpy/vim-yaml'

Plug 'fatih/vim-go'

Plug 'cakebaker/scss-syntax.vim'

let g:colorizer_auto_filetype='css,scss,sass'
let g:colorizer_skip_comments=1
let g:colorizer_disable_bufleave=1
Plug 'chrisbra/Colorizer'

Plug 'jiangmiao/auto-pairs'
"Plug 'yuezk/vim-js'
"Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'neoclide/vim-jsx-improve'
let g:tabprefix = ""
"Plug 'tpope/vim-flagship'
" Plug 'othree/yajs.vim' " ES6

" Plug 'NLKNguyen/papercolor-theme'
" Plug 'junegunn/seoul256.vim' " paper beats seoul
Plug 'dracula/vim'

let g:markdown_enable_spell_checking = 0
Plug 'gabrielelana/vim-markdown'

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
