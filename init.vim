"------------------------------------------------------------------------------------------------------------------------------------------------
"Basic setters
"------------------------------------------------------------------------------------------------------------------------------------------------
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

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=120 
set expandtab 
set smartindent
set autoindent 
set fileformat=unix

"The below code sets tab config to specific files mentioned only.
"Tab configurations for various languages
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
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'udalov/kotlin-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'ap/vim-css-color'
Plug 'nanotech/jellybeans.vim'
call plug#end()
