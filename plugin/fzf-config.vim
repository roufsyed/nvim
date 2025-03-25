"FZF config
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --preview="bat --theme={ansi} --color always --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow'.shellescape(<q-args>), 1, <bang>0)

set timeoutlen=500 "Set timeout length to 500 ms

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" /* " Command	List */
" /* " :Files [PATH]	Files (runs $FZF_DEFAULT_COMMAND if defined) */
" /* " :GFiles [OPTS]	Git files (git ls-files) */
" /* " :GFiles?	Git files (git status) */
" /* " :Buffers	Open buffers */
" /* " :Colors	Color schemes */
" /* " :Ag [PATTERN]	ag search result (ALT-A to select all, ALT-D to deselect all) */
" /* " :Rg [PATTERN]	rg search result (ALT-A to select all, ALT-D to deselect all) */
" /* " :Lines [QUERY]	Lines in loaded buffers */
" /* " :BLines [QUERY]	Lines in the current buffer */
" /* " :Tags [QUERY]	Tags in the project (ctags -R) */
" /* " :BTags [QUERY]	Tags in the current buffer */
" /* " :Marks	Marks */
" /* " :Windows	Windows */
" /* " :Locate PATTERN	locate command output */
" /* " :History	v:oldfiles and open buffers */
" /* " :History:	Command history */
" /* " :History/	Search history */
" /* " :Snippets	Snippets (UltiSnips) */
" /* " :Commits	Git commits (requires fugitive.vim) */
" /* " :BCommits	Git commits for the current buffer; visual-select lines to track changes in the range */
" /* " :Commands	Commands */
" /* " :Maps	Normal mode mappings */
" /* " :Helptags	Help tags 1 */
" /* " :Filetypes	File types */

" nnoremap <leader>f :Files<cr>
" nnoremap <leader>r :Rg<CR>
" nnoremap <leader>b :Windows<cr>
" nnoremap <leader><S-b> :Buffers<cr>
nnoremap <leader>s :BLines<cr>
nnoremap <leader>l :Lines<cr>
" nnoremap <leader>m :Marks<cr>
" nnoremap <leader>M :Maps<cr>


" Find files using Telescope command-line sugar.
nnoremap <leader>f :Telescope find_files<cr>
nnoremap <leader>r :Telescope live_grep<cr>
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <leader>h :Telescope help_tags<cr>
nnoremap <leader><Tab> :Telescope oldfiles<cr>
nnoremap <leader>gg :Telescope git_files<cr>
nnoremap <leader>gt :Telescope treesitter<cr>
nnoremap <leader>c :Telescope commands<cr>
nnoremap <leader>j :Telescope jumplist<cr>
nnoremap <leader>m :Telescope marks<cr>
nnoremap <leader>M :Telescope keymaps<cr>


lua << EOF

local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")

-- 🔹 LSP Pickers Mappings with Telescope
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, opts)  -- List references
vim.keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, opts)  -- List incoming calls
vim.keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, opts)  -- List outgoing calls
vim.keymap.set("n", "<leader>ld", builtin.lsp_document_symbols, opts)  -- List document symbols
vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, opts)  -- List workspace symbols
vim.keymap.set("n", "<leader>ls", builtin.lsp_dynamic_workspace_symbols, opts)  -- Dynamically list workspace symbols
vim.keymap.set("n", "<leader>lx", function() builtin.diagnostics({ bufnr = 0 }) end, opts)  -- List diagnostics for current buffer
vim.keymap.set("n", "<leader>lX", builtin.diagnostics, opts)  -- List diagnostics for all buffers
vim.keymap.set("n", "<leader>lI", builtin.lsp_implementations, opts)  -- Go to implementation(s)
vim.keymap.set("n", "<leader>lD", builtin.lsp_definitions, opts)  -- Go to definition(s)
vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, opts)  -- Go to type definition(s)

EOF
