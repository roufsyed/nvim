set background=dark

" Spacegray theme
let g:spacegray_use_italics = 1
let g:spacegray_low_contrast = 0
colorscheme spacegray

" lualine setup call
" lua << EOF
" require('lualine').setup {
"   options = {
"     theme = 'tokyonight'
"   }
" }
" EOF

"Jellybeans bg color overide                    
"  let g:jellybeans_overrides = {
"  \    'background': { 'guibg': '#444444'},
"  \    'Todo': { 'guifg': '303030', 'guibg': 'e23131',
"  \              'ctermfg': 'Black', 'ctermbg': 'red',
"  \              'attr': 'bold' },
"  \    'Comment': { 'guifg': 'cccccc' },
"  \}
" let g:jellybeans_use_term_italics = 1
" colorscheme jellybeans

" Gruvbox theme
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_italicize_comments= 1
" let g:gruvbox_number_column='bg0'
" let g:gruvbox_sign_column='bg0'
" let g:gruvbox_italic=1
" let g:gruvbox_bold=1
" let g:gruvbox_hls_cursor='aqua'
" let g:gruvbox_vert_split='bg0'
" colorscheme gruvbox

" Nightfox/ Terafox theme
" lua << EOF
" require('nightfox').setup({
"   options = {
"     styles = {
"       comments = "italic",
"       keywords = "bold",
"       conditionals = "NONE",
"       constants = "NONE",
"       functions = "NONE",
"       numbers = "NONE",
"       operators = "NONE",
"       strings = "NONE",
"       types = "NONE",
"       variables = "NONE"
"     }
"   }
" })
" EOF
" colorscheme terafox

" Tokyonight theme
" lua << EOF
" vim.g.tokyonight_style = "night"
" vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
" vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
" EOF
" colorscheme tokyonight

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

" Terminal highlight group configuration
" Changes background color for nvim built-in terminal
lua << EOF
    vim.api.nvim_create_augroup("_terminal", {
        clear = true 
    })

    vim.api.nvim_set_hl(0, "_terminal", {
        bg = "#000000",
        fg = "fg",
    })

    vim.api.nvim_create_autocmd("TermOpen", {
      command = "setlocal winhighlight=Normal:_terminal",
      group = "_terminal",
    })
EOF

" Solution to the issue: where sometimes the window does not fullscreen properly
lua << EOF
    -- Redraw on start
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function()
        local pid, WINCH = vim.fn.getpid(), vim.loop.constants.SIGWINCH
        vim.defer_fn(function() vim.loop.kill(pid, WINCH) end, 20)
      end
    })
EOF
