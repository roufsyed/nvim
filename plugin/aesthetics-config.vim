set background=dark

" --------------------------------------
" Liked colorscheme
" --------------------------------------
" colorscheme base16-kanagawa
" colorscheme base16-default-dark " Second most preferred
" colorscheme base16-tokyo-night-terminal-dark " third most preferred
" colorscheme base16-gruvbox-material-dark-hard
" colorscheme base16-classic-dark
" colorscheme base16-catppuccin
" colorscheme jellybeans

" lua << EOF
" 	require("tokyonight").setup({
" 	  style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
" 	  transparent = false, -- Enable this to disable setting the background color
" 	  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
" 	  styles = {
" 		keywords = { italic = false },
" 		-- Background styles. Can be "dark", "transparent" or "normal"
" 		sidebars = "dark", -- style for sidebars, see below
" 		floats = "dark", -- style for floating windows
" 	  },
" 	  dim_inactive = false, -- dims inactive windows
" 	  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
" 	})
" require('tokyonight').load()
" EOF

lua << EOF
	require('onedark').setup {
		style = 'cool'
	}
	require('onedark').load()
EOF

" lua << EOF
" 	-- Default options
" 	require('nightfox').setup({
" 	  options = {
" 		-- Compiled file's destination location
" 		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
" 		compile_file_suffix = "_compiled", -- Compiled file suffix
" 		transparent = true,    -- Disable setting background
" 		terminal_colors = false, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
" 		dim_inactive = false,   -- Non focused panes set to alternative background
" 		styles = {              -- Style to be applied to different syntax groups
" 		  comments = "italic",    -- Value is any valid attr-list value `:help attr-list`
" 		},
" 		inverse = {             -- Inverse highlight for different types
" 		  match_paren = false,
" 		  visual = false,
" 		  search = false,
" 		},
" 	  },
" 	})
"
" 	-- setup must be called before loading
" 	vim.cmd("colorscheme nightfox")
" EOF

" Cursor Settings
" Use a line cursor within insert mode and a block cursor everywhere else.
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q" "Insert mode
let &t_SR = "\e[4 q" "REPLACE mode
let &t_EI = "\e[2 q" "Normal mode

" ---------------------------------------------------------------
" Highlight
" NOTE: highlight should be kept on last line always to overide whatever is set by the colorscheme
" ---------------------------------------------------------------
highlight WinSeparator guifg=#FFFFFF guibg=NONE ctermbg=NONE ctermfg=NONE " To make window separator none, a line will be used.
" highlight TabLineSel guifg=#a9b665 guibg=#00000000 gui=bold
" highlight TabLine guifg=#bbc2cf guibg=#272727 gui=none
" highlight TabLineFill guibg=#272727
" highlight SignColumn guifg=#00000000 guibg=#00000000
" highlight TabLineCloseSel guibg=#00000000
" highlight TabLineClose guibg=#272727

" highlight NormalNC guibg=#202020
" highlight Normal guibg=#202020
" highlight LineNr ctermfg=11 guifg=#605958 guibg=none
" highlight normal ctermbg=NONE ctermfg=NONE
" highlight Normal guibg=#191919

" "TokyoNight specific
highlight TabLineSel guifg=#c0caf5 guibg=#00000000 gui=bold
highlight SignColumn guifg=#00000000 guibg=#00000000
" highlight TabLine guifg=#bbc2cf guibg=#272727 gui=none
" highlight TabLineFill guibg=#272727
" highlight TabLineCloseSel guibg=#00000000
" highlight TabLineClose guibg=#272727


" Terminal highlight group configuration
" Changes background color for nvim built-in terminal
" lua << EOF
"     vim.api.nvim_create_augroup("_terminal", {
"         clear = true 
"     })
"
"     vim.api.nvim_set_hl(0, "_terminal", {
"         bg = "#000000",
"         fg = "#FFFFFF",
"     })
"
"     vim.api.nvim_create_autocmd("TermOpen", {
"       command = "setlocal winhighlight=Normal:_terminal",
"       group   = "_terminal",
"     })
" EOF

" Solution to the issue: where sometimes the window does not fullscreen properly on autostart
lua << EOF
    -- Redraw on start
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function()
        local pid, WINCH = vim.fn.getpid(), vim.loop.constants.SIGWINCH
        vim.defer_fn(function() vim.loop.kill(pid, WINCH) end, 20)
      end
    })
EOF
