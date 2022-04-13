"-----------------------------------------------------------------------------------------------------------------------------------------------
"Basic setters
"-----------------------------------------------------------------------------------------------------------------------------------------------
set number       " Set number
set termguicolors " True color
set rnu 		 " Set relative number
set wrap   		 " Line wrapper
set linebreak    " Sends entire word to next line rather than a single letter(WordWrap)
" set autochdir    " Auto change directory: To make editting file directory default
set mouse=a
autocmd BufRead,BufNewFile * setlocal signcolumn=yes  " Enable signcolumn for all the buffers
autocmd FileType netrw setlocal signcolumn=no  " Disable signcolumn in netrw
set laststatus=2 " Enable status line
set t_Co=256      " Enable true color
set syntax=on    "Enable synatx highlighting
set nohlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set hidden      " Keeps files open in the background.
set noerrorbells " Turns off bell sound
set noswapfile  " Disable swap files
set scrolloff=8 " Doesn't allow cursor to go all the way to the last line
set noshowmode  " Hides default mode display

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=120 
set expandtab 
set smartindent
set autoindent 
set fileformat=unix

"The below code sets tab config to specific files mentioned only.
au BufNewFile,BufRead *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html,*.php 
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

"Remap leader 
let mapleader = "," "map leader to coma 

"-----------------------------------------------------------------------------------------------------------------------------------------------
"Plugs - Various plugins to make life simpler.
"-----------------------------------------------------------------------------------------------------------------------------------------------
call plug#begin()
Plug 'tpope/vim-commentary' " comment and uncomment multiple lines easily
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'udalov/kotlin-vim' " Kotlin syntax highlighting and autocompletion
Plug 'itchyny/lightline.vim' " Status line
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " fuzzy file search for vim, prereq:fzf
Plug 'Raimondi/delimitMate' " Quatation marks and bracket completion
Plug 'tpope/vim-surround' " Surrounds with quotations, brackets and tags
Plug 'mhinz/vim-signify' " Git signs in the sign column
Plug 'tpope/vim-fugitive' " Git inside the editor
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Mostly using it for better syntax highlighting
Plug 'ap/vim-css-color' " Preview colors in css files
Plug 'nanotech/jellybeans.vim' " ColorScheme
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()
