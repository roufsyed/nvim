"-----------------------------------------------------------------------------------------------------------------------------------------------
" Basic setters
"-----------------------------------------------------------------------------------------------------------------------------------------------
set number                " Set number
set termguicolors         " True color
set rnu                   " Set relative number
set wrap                  " Line wrapper
set mouse=a               " Enable mouse for all modes
set splitright            " Open split in right
set clipboard=unnamedplus " Use system clipboard
set signcolumn=yes        " Enable signcolumn for all the buffers
set cmdheight=1           " Status line without command mode line
set laststatus=3          " Enable status line and set it to be global for all splits
set t_Co=256              " Enable true color
set syntax=on             " Enable synatx highlighting
set nohlsearch            " Highlight all search results
set smartcase             " Enable smart-case search
set ignorecase            " Always case-insensitive
set incsearch             " Searches for strings incrementally
set hidden                " Keeps buffer open in the background without saving it
set noerrorbells          " Turns off bell sound
set noswapfile            " Disable swap files
set scrolloff=8           " Doesn't allow cursor to go all the way to the last line
set noshowmode            " Hides default mode display
set cursorline            " Highlights cursor row
" set showtabline=1       " disable tabline (useful when tabs are shown in statusline)

" Cusorline config to hide it in inactive window
augroup CursorLine 
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Nvim built-in terminal config
" augroup terminal_settings
" autocmd!
" autocmd BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave term://* stopinsert

" Ignore various filetypes as those will close terminal automatically
" Ignore fzf, ranger, coc
" autocmd TermClose term://*
"       \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
"       \   call nvim_input('<CR>')  |
"       \ endif
" augroup END

" Some servers have issues with backup files, see #649.
" so disabling backup files
set nobackup
set nowritebackup

" Tab Config
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=120 
set noexpandtab " Expandtab uses spaces instead of tabs
set smartindent
set autoindent 
set fileformat=unix

" Tab config specific to filetypes
au BufNewFile,BufRead *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html,*.php,*.lua 
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=120 |
    \ set noexpandtab |
    \ set autoindent |
    \ set fileformat=unix

"Remap leader 
let mapleader = "," "map leader to coma 

"------------------------------------------------------------------------------
" Plugins 
"------------------------------------------------------------------------------
call plug#begin()
Plug 'nvim-lualine/lualine.nvim'                                                               " Status line
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                                            " Actual fzf program
Plug 'junegunn/fzf.vim'                                                                        " Fuzzy file search for vim, prereq:fzf
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                                    " For better syntax colors
Plug 'lewis6991/impatient.nvim'                                                                " Improves startup time
Plug 'antoinemadec/FixCursorHold.nvim'                                                         " Fix CursorHold Performance
Plug 'neoclide/coc.nvim', {'branch': 'release'}                                                " LSP
Plug 'Raimondi/delimitMate'                                                                    " Quatation marks and brackets completion
Plug 'tpope/vim-fugitive'                                                                      " Git inside the editor
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }                                      " Colors preview for hexcodes
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown']}  " Markdown preview
Plug 'mhinz/vim-signify'                                                                       " Git signs in sign column
Plug 'numToStr/Comment.nvim'                                                                   " Easy comments
Plug 'kyazdani42/nvim-web-devicons'                                                            " Icons in editor
Plug 'kyazdani42/nvim-tree.lua'                                                                " File tree structure
Plug 'kylechui/nvim-surround'                                                                  " Surrounds with quotation, brackets and tags
Plug 'anuvyklack/hydra.nvim'                                                                   " Custom mode
Plug 'seblj/nvim-tabline'                                                                      " Fancy tab line
Plug 'puremourning/vimspector'                                                                 " Debugger - Jest, junit integration, etc
Plug 'nvim-lua/plenary.nvim'                                                                   " Dependency of todo-comments and for UI Component designs
Plug 'junegunn/vim-easy-align'                                                                 " expression alignment
Plug 'folke/todo-comments.nvim'                                                                " Shows todos, warnings, notes, etc in quickfix, trouble or loclist
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}                                                  " Terminal
Plug 'nanotech/jellybeans.vim'                                                                 " Colorscheme
Plug 'navarasu/onedark.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
" Java
Plug 'mfussenegger/nvim-jdtls'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
call plug#end()



"-------------------------------------------
" Lua embedded calls
"-------------------------------------------
lua << EOF
    require("Comment").setup()
    require("nvim-surround").setup()
    require("todo-comments").setup ()
EOF
