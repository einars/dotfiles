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

Plug 'sirtaj/vim-openscad'

Plug 'mattn/webapi-vim'

" expand snippet: ctrl-f ,
" html snippet: !
let g:user_emmet_install_global=0
let g:user_emmet_leader_key='<C-F>'
exec 'source ' . EditorRoot() . '/snippets/emmet.vim'
Plug 'mattn/emmet-vim'
autocmd FileType php,html,javascript,javascriptreact EmmetInstall
autocmd FileType css,scss EmmetInstall

" color themes
" papercolor is enough for everything
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'

Plug 'rickhowe/diffchar.vim'
let g:DiffUnit="Word2"

let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = EditorRoot() . "/snippets"
Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'

Plug 'arcticicestudio/nord-vim'

"Plug 'clojure-vim/async-clj-omni'

" dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'

Plug 'junegunn/goyo.vim'

Plug 'tpope/vim-fireplace'
Plug 'mfussenegger/nvim-lint'


Plug 'vlime/vlime'
" do not optimize
let g:vlime_compiler_policy = {"DEBUG": 3}
" misc settings
let g:vlime_enable_autodoc = v:true
let g:vlime_window_settings = {'sldb': {'pos': 'belowright', 'vertical': v:true}, 'inspector': {'pos': 'belowright', 'vertical': v:true}, 'preview': {'pos': 'belowright', 'size': v:null, 'vertical': v:true}}

call plug#end()

lua <<EOF
require('telescope').setup{ defaults = { file_ignore_patterns = {
  "node_modules",
  #"protected/lib/",
  "protected/test/",
  "protected/plugins/",
  "protected/vendor/",
  } } }

require("lint").linters_by_ft = {
  clojure = {"clj-kondo"},
}

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


