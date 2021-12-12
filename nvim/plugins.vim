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
Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-sleuth'

"Plug 'evanleck/vim-svelte', { 'branch': 'main' }
"Plug 'leafOfTree/vim-svelte-plugin'

Plug 'sirtaj/vim-openscad'

Plug 'mattn/webapi-vim'

let g:user_emmet_install_global=0
let g:user_emmet_leader_key='<C-F>'
exec 'source ' . EditorRoot() . '/snippets/emmet.vim'
Plug 'mattn/emmet-vim'
autocmd FileType php,html,javascript,javascriptreact EmmetInstall
autocmd FileType css,scss EmmetInstall

" color themes
" papercolor - fav white
Plug 'NLKNguyen/papercolor-theme'
" gruvbok - very nice dark
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/blue-moon'
Plug 'embark-theme/vim'
Plug 'EdenEast/nightfox.nvim'

Plug 'equalsraf/neovim-gui-shim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = EditorRoot() . "/snippets"
" Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'


"Plug 'RishabhRD/popfix'
"Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'clojure-vim/async-clj-omni'

" dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'

Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-fireplace'

Plug 'vlime/vlime'

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "php", "javascript", "scala", "svelte", "python", "rust", "scss", "css", "zig" },
  highlight = { enable = true },
  indent = { enable = true },
}
EOF

"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require('telescope').setup{ defaults = { file_ignore_patterns = {
  "node_modules",
  #"protected/lib/",
  "protected/test/",
  "protected/plugins/",
  "protected/vendor/",
  } } }
EOF

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 5,
        \ 'scope': ['css','scss'],
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })


au User Ncm2Plugin call  ncm2#override_source('async_clj_omni', { 'complete_length': 3 })

