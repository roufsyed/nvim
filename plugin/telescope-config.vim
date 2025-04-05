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

" command! -bang -nargs=* Find call fzf#vim#grep('rg --preview="bat --theme={ansi} --color always --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow'.shellescape(<q-args>), 1, <bang>0)

" set timeoutlen=500 "Set timeout length to 500 ms

" [[B]Commits] Customize the options used by 'git log':
" let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

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
" nnoremap <leader>s :BLines<cr>
" nnoremap <leader>l :Lines<cr>
" nnoremap <leader>m :Marks<cr>
" nnoremap <leader>M :Maps<cr>


lua << EOF
require('telescope').setup{
  defaults = {
    layout_strategy = "horizontal",  -- Alternative: "bottom_pane"
    layout_config = {
      height = 0.5,  -- 40% of screen height
      width = 0.8,   -- 50% of screen width
    },
  },
  pickers = {
    find_files = { previewer = false },  -- Explicitly disable preview
    buffers = { previewer = false },    -- Explicitly disable preview
  }
}

local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

-- 🔹 Find files & general Telescope mappings
vim.keymap.set('n', '<Space><Space>', builtin.builtin, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>H', builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set('n', '<leader><Tab>', builtin.oldfiles, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gt', builtin.treesitter, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>c', builtin.commands, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>j', builtin.jumplist, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>m', builtin.marks, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>M', builtin.keymaps, { noremap = true, silent = true })

-- 🔹 LSP Pickers (Direct Keybindings)
vim.keymap.set("n", "<leader>lr", function() builtin.lsp_references() end, opts)
vim.keymap.set("n", "<leader>li", function() builtin.lsp_incoming_calls() end, opts)
vim.keymap.set("n", "<leader>lo", function() builtin.lsp_outgoing_calls() end, opts)
vim.keymap.set("n", "<leader>ld", function() builtin.lsp_document_symbols() end, opts)
vim.keymap.set("n", "<leader>lw", function() builtin.lsp_workspace_symbols() end, opts)
vim.keymap.set("n", "<leader>ls", function() builtin.lsp_dynamic_workspace_symbols() end, opts)
vim.keymap.set("n", "<leader>lI", function() builtin.lsp_implementations() end, opts)
vim.keymap.set("n", "<leader>lD", function() builtin.lsp_definitions() end, opts)
vim.keymap.set("n", "<leader>lt", function() builtin.lsp_type_definitions() end, opts)

-- 🔹 LSP Diagnostics (Handled Separately)
vim.keymap.set("n", "<leader>lx", function() builtin.diagnostics({ bufnr = 0 }) end, opts)  -- Current buffer diagnostics
vim.keymap.set("n", "<leader>lX", builtin.diagnostics, opts)  -- All buffers diagnostics


vim.keymap.set("v", "<leader>r", function()
    vim.cmd('normal! "zy') -- Copy selection to register z
    local selected_text = vim.fn.getreg("z") -- Get selected text
    selected_text = selected_text:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "\\%1") -- Escape only regex special characters for Ripgrep
    selected_text = selected_text:gsub("\n", " ") -- Convert newlines to spaces (Fix for multi-line selection)

    builtin.live_grep({ default_text = selected_text })
end, { noremap = true, silent = true })
EOF
