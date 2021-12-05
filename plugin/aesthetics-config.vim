set background=dark

"Jellybeans
 " let g:jellybeans_overrides = {
 " \    'background': { 'guibg': '#000000'},
 " \}
 colorscheme jellybeans

" lightline config
 let g:lightline = {
       \ 'colorscheme': 'jellybeans',
       \ }

"Cursor Settings
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
let &t_EI = "\e[2 q" "Normal mode

