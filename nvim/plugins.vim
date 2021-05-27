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
Plug 'leafOfTree/vim-svelte-plugin'

Plug 'sirtaj/vim-openscad'

Plug 'mattn/webapi-vim'

let g:user_emmet_install_global=0
let g:user_emmet_leader_key='<C-F>'
exec 'source ' . EditorRoot() . '/snippets/emmet.vim'
Plug 'mattn/emmet-vim'
autocmd FileType php,html,javascript,javascriptreact EmmetInstall
autocmd FileType css,scss EmmetInstall

"Plug 'ctrlpvim/ctrlp.vim'

Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim'

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

" dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "php", "javascript", "scala", "svelte", "python", "rust", "scss", "css" },
  highlight = { enable = true },
  indent = { enable = true, disable_filetype = { "python" } },
}
EOF
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
