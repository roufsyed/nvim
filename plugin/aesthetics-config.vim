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
colorscheme jellybeans

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

" Note highlight should be kept on last line always to overide whatever is set by the colorscheme
highlight WinSeparator ctermbg=NONE ctermfg=NONE " To make window separator none, a line will be used.
highlight normal ctermbg=NONE ctermfg=NONE " To make window separator none, a line will be used.
highlight TabLineSel guifg=#a9b665 guibg=#00000000 gui=bold
highlight TabLine guifg=#bbc2cf guibg=#272727 gui=none
highlight TabLineFill guibg=#272727
highlight SignColumn guifg=#00000000 guibg=#00000000
highlight TabLineCloseSel guibg=#00000000
highlight TabLineClose guibg=#272727
" highlight Normal guibg=#191919
" highlight NormalNC guibg=#151515
" highlight LineNr ctermfg=11 guifg=#605958 guibg=none

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
