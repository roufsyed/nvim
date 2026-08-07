"-----------------------------------------------------------------------------------------------------------------------------------------------
" Basic setters
"-----------------------------------------------------------------------------------------------------------------------------------------------
set number                " Set number
set termguicolors         " True color
set rnu                   " Set relative number
set wrap                " Line wrapper set linebreak		
set linebreak         " wrap at word boundaries, not mid-word
set showbreak=↪\      " optional: shows indicator at wrapped lines
set mouse=a               " Enable mouse for all modes
set splitright            " Open split in right
set clipboard=unnamedplus " Use system clipboard
set signcolumn=yes        " Enable signcolumn for all the buffers
set cmdheight=1           " Status line without command mode line
set laststatus=3          " Enable status line and set it to be global for all splits / Getting override in lualine config
set t_Co=256              " Enable true color
set syntax=on             " Enable synatx highlighting
set hlsearch              " Highlight all search results
set smartcase             " Enable smart-case search
set ignorecase            " Always case-insensitive
set incsearch             " Searches for strings incrementally
set hidden                " Keeps buffer open in the background without saving it
set noerrorbells          " Turns off bell sound
set noswapfile            " Disable swap files
set scrolloff=0         
set scrolljump=1
set noshowmode            " Hides default mode display
set cursorline            " Highlights cursor row
" set showtabline=1       " disable tabline (useful when tabs are shown in statusline)

"Remap leader 
let mapleader = "," "map leader to coma 

" Cusorline config to hide it in inactive window
augroup CursorLine 
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Some servers have issues with backup files, see #649.
" so disabling backup files
set nobackup
set nowritebackup

" Tab Config
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=0
set noexpandtab " Use tabs instead of spaces
set smartindent
set autoindent 
set fileformat=unix

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


" Tab config specific to filetypes
" au BufNewFile,BufRead *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html,*.php,*.lua 
"     \ set tabstop=2 |
"     \ set softtabstop=2 |
"     \ set shiftwidth=2 |
"     \ set textwidth=120 |
"     \ set noexpandtab |
"     \ set autoindent |


"------------------------------------------------------------------------------
" Plugins 
"------------------------------------------------------------------------------
call plug#begin()
Plug 'nvim-lualine/lualine.nvim'                                  " Status line
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-fugitive'                                         " Git
Plug 'sindrets/diffview.nvim'									  " Git diff
Plug 'f-person/git-blame.nvim'                                    " Blame
Plug 'lewis6991/gitsigns.nvim'
Plug 'rmagatti/auto-session'                                      " Session
Plug 'nvim-pack/nvim-spectre'                                     " Search and replace
Plug 'dhruvasagar/vim-table-mode'                                 " Table rendering
Plug 'MeanderingProgrammer/render-markdown.nvim'                  " Live markdown rendering
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug '3rd/image.nvim'											  " Image rendering
Plug 'numToStr/Comment.nvim'                                      " Easy comments
Plug 'kyazdani42/nvim-web-devicons'                               " Icons in editor
Plug 'stevearc/oil.nvim'										  " File tree structure
" Plug 'refractalize/oil-git-status.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'kylechui/nvim-surround'                                     " Surrounds with quotation, brackets and tags
Plug 'nvimtools/hydra.nvim'                                      " Custom mode
Plug 'seblj/nvim-tabline'                                         " Fancy tab line
Plug 'nvim-lua/plenary.nvim'                                      " Dependency of todo-comments, telescope and for UI Component designs
Plug 'junegunn/vim-easy-align'                                    " expression alignment
Plug 'folke/todo-comments.nvim'                                   " Shows todos, warnings, notes, etc in quickfix, trouble or loclist
Plug 'navarasu/onedark.nvim'                                      " Theme
Plug 'huyvohcmc/atlas.vim'										  " Theme
Plug 'lukas-reineke/indent-blankline.nvim'                        " Indent Guide Lines
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main', 'do': ':TSUpdate'} " For better syntax colors
Plug 'folke/flash.nvim'											  " Jump navigation
Plug 'catgoose/nvim-colorizer.lua'                                " Hex Colors Preview (norcalli's is dead since 2021)
Plug 'nvim-telescope/telescope.nvim'                              " Fuzzy search
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Fuzzy fzf
Plug 'neovim/nvim-lspconfig'                                      " LSP configurations
Plug 'williamboman/mason.nvim'                                    " LSP Installer
Plug 'williamboman/mason-lspconfig.nvim'                          " Mason configs wrapper
Plug 'mfussenegger/nvim-jdtls'                                    " Java: jdtls extensions (organize imports, generate, extract, tests)
Plug 'j-hui/fidget.nvim'                                          " LSP progress
Plug 'hrsh7th/nvim-cmp'                                           " Completion engine
Plug 'hrsh7th/cmp-nvim-lsp'                                       " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'                                         " Buffer completion
Plug 'hrsh7th/cmp-path'                                           " Path completion
Plug 'hrsh7th/cmp-cmdline'                                        " Command-line completion
Plug 'saadparwaiz1/cmp_luasnip'                                   " Snippet completion
Plug 'L3MON4D3/LuaSnip'                                           " Snippet engine
Plug 'hedyhli/outline.nvim'										  " Outline symbols list view
Plug 'folke/trouble.nvim'                                         " Diagnostic in quickfix
Plug 'lewis6991/async.nvim'                                       " Dependency of refactoring.nvim
Plug 'ThePrimeagen/refactoring.nvim'                              " Extract to method, etc
Plug 'aznhe21/actions-preview.nvim'                               " Code action in pop up with preview
Plug 'BranimirE/fix-auto-scroll.nvim'							  " Fix auto scroll to middle of the editor on split change
Plug 'nvimtools/none-ls.nvim'
Plug 'rcarriga/nvim-notify'
call plug#end()

"-------------------------------------------
" Lua embedded calls
"-------------------------------------------
lua << EOF
    require("Comment").setup()
    require("nvim-surround").setup()
    require("todo-comments").setup()
	require('refactoring').setup()
	require("outline").setup()
EOF
