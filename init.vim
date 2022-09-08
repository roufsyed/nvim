"-----------------------------------------------------------------------------------------------------------------------------------------------
"Basic setters
"-----------------------------------------------------------------------------------------------------------------------------------------------
set number       " Set number
set termguicolors " True color
set rnu 		 " Set relative number
set wrap   		 " Line wrapper
set mouse=a

autocmd BufRead,BufNewFile * setlocal signcolumn=yes  " Enable signcolumn for all the buffers
autocmd FileType netrw setlocal signcolumn=no  " Disable signcolumn in netrw

set laststatus=3 " Enable status line and set it to be global for all splits
set t_Co=256      " Enable true color
set syntax=on    "Enable synatx highlighting
set nohlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set hidden      " Keeps buffer open in the background without saving it
set noerrorbells " Turns off bell sound
set noswapfile  " Disable swap files
set scrolloff=8 " Doesn't allow cursor to go all the way to the last line
set noshowmode  " Hides default mode display
set cursorline " Highlights cursor row

" use filetype.lua instead of filetype.vim
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" Cusorline config to hide it in inactive window
augroup CursorLine 
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Nvim built-in terminal config
augroup terminal_settings
autocmd!

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Ignore various filetypes as those will close terminal automatically
" Ignore fzf, ranger, coc
autocmd TermClose term://*
      \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
      \   call nvim_input('<CR>')  |
      \ endif
augroup END

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Tab Config
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=120 
set expandtab 
set smartindent
set autoindent 
set fileformat=unix

" Tab config for specific filetypes
au BufNewFile,BufRead *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html,*.php,*.lua 
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

"Remap leader 
let mapleader = "," "map leader to coma 

"------------------------------------------------------------------------------
"Plugins 
"------------------------------------------------------------------------------
call plug#begin()
Plug 'nvim-lualine/lualine.nvim' " Status line
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Actual fzf program
Plug 'junegunn/fzf.vim' " fuzzy file search for vim, prereq:fzf
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " for better syntax colors
Plug 'antoinemadec/FixCursorHold.nvim' " Fix CursorHold Performance
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'Raimondi/delimitMate' " Quatation marks and brackets completion
Plug 'tpope/vim-fugitive' " Git inside the editor
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Colors preview for hexcodes
Plug 'davidgranstrom/nvim-markdown-preview' " Markdown preview and hot-reload
Plug 'mhinz/vim-signify' " Git signs in sign column
Plug 'numToStr/Comment.nvim' " Easy comments 
Plug 'kyazdani42/nvim-web-devicons' " Icons in editor
Plug 'kyazdani42/nvim-tree.lua' " File tree structure
Plug 'kylechui/nvim-surround' " Surrounds with quotation, brackets and tags
Plug 'ackyshake/Spacegray.vim' " Space colorScheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' } "Tokyonight colorscheme
Plug 'anuvyklack/hydra.nvim' " Custom mode
Plug 'seblj/nvim-tabline' " Fancy tab line
Plug 'liuchengxu/vista.vim' " Symbols ctags and more
Plug 'udalov/kotlin-vim' " Kotlin syntax highlighting and autocompletion
Plug 'puremourning/vimspector' " Debugger
Plug 'lewis6991/impatient.nvim' " Improves startup time 
call plug#end()

lua << EOF
    require('Comment').setup()
    require("nvim-surround").setup()
    require("lualine").setup()
EOF
