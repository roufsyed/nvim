set background=dark
"colorscheme atlas

lua << EOF
-- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	require('onedark').setup {
		style = 'dark'
	}
	require('onedark').load()
EOF

" Cursor Settings
let &t_SI = "\e[6 q" "Insert mode
let &t_SR = "\e[4 q" "REPLACE mode
let &t_EI = "\e[2 q" "Normal mode

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

" ---------------------------------------------------------------
" Highlight
" NOTE: highlight should be kept on last line always to overide whatever is set by the colorscheme
" ---------------------------------------------------------------
" highlight WinSeparator guifg=#FFFFFF guibg=NONE ctermbg=NONE ctermfg=NONE " To make window separator none, a line will be used.
" highlight CursorLine ctermbg=236 guibg=#2E333D
