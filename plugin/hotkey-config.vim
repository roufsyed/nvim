"-----------------------------------------------------------------------------------------------------------------------------------------------
"Hotkey configurations
"-----------------------------------------------------------------------------------------------------------------------------------------------

"remap to jj to esc and to get into normal mode in terminal
imap jj <Esc>
tnoremap jj <C-\><C-n>

" Specific to toggleterm plugin
nmap <silent><leader>T :ToggleTerm direction=horizontal size=12 hide=1<CR>
tnoremap <silent><leader>T :ToggleTerm hide<CR>

"Toggle vertical and horizontal built-in terminal
 " nmap <silent><F4> :split term://bash<CR>jj<C-w>L:vertical resize 60<CR>iclear<CR>
 " tnoremap <silent><F4> <Esc><C-\><C-n>:bd!<CR>

" nmap <silent><F3> :split term://bash<CR>jj<C-w>J:resize 14<CR>iclear<CR>
" tnoremap <silent><F3> <Esc><C-\><C-n>:bd!<CR>

" unhighlight
nnoremap <Esc> :noh<CR>

" Select all
nnoremap <C-a> ggVG

" Delete line 
nnoremap X Vx

" Register
nnoremap <silent><leader>R :Telescope registers<CR>

" Macros for adding, removing checklist, putting tick and removing it
" [ ] testing
let @a='^ca[jjx$' " Remove checkbox
let @b='^i[ ] jj$'" Add checkbox
let @c='^ci[✓jj$' " Tick checkbox
let @d='^ci[ jj$' " Clear checkbox
let @e='^ci[~jj$' " Partially done
let @x='^ci[✕jj$' " Not done

" Buffer navigations
nnoremap <silent><leader>n :bn<cr>

nnoremap <silent><leader>d :bd<cr>
nnoremap H <C-o>
nnoremap L <C-i>


"Disabled because it creates a 200ms delay due to ,d is reserved to delete buffer
" nnoremap <silent><leader>dd :bd!<cr> 

"save and quit
nnoremap <leader>w :update<CR>
nnoremap <leader>q :q<CR>

"Search and replace
" c : confirm before deleting
" g : global edit
nnoremap <leader>sr :%s/<C-r>+//gc

" Search for selected text
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>
"
" Project-wide search (similar to IntelliJ's Cmd+Shift+F)
function! ProjectSearch()
  let pattern = input("Search project for: ")
  if pattern != ""
    " You can replace 'grep' with 'rg' (ripgrep) or 'ag' (silver searcher) if installed
    execute 'silent grep! "' . pattern . '" .'
    copen  " Open the quickfix window with results
  endif
endfunction

" Map it to your preferred key combination
nnoremap <leader>F :call ProjectSearch()<CR>

"to open init and source
function! Init()
    cd ~/.config/nvim/
    :e init.vim
endfunction

nnoremap <silent><F8> :call Init()<cr>
nnoremap ss :source %<CR>

" Redo
nnoremap U :redo<cr>

"nvim-tree toggle
nnoremap <silent><leader>e :NvimTreeToggle<cr>

" opens a new tab
nnoremap <silent><leader>t :tabnew<cr>
nnoremap <silent><leader>v :vsp<cr>
nnoremap <silent><leader>h :sp<cr>

" Quickfix list: cnext, cprevious and copen
nmap }} :cnext<cr>
nmap {{ :cprevious<cr>
nmap q :cclose<cr>
nmap Q :copen<cr>

"Move texts around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

"To move to a different window in terminal and terminal buffer
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Rename tab
nnoremap RT :LualineRenameTab 

" Git Shortcuts
nnoremap <leader>gg  : Git<cr>:only<cr>
nnoremap <leader>ga  : Git add %<cr>
nnoremap <leader>gc  : Git commit<cr>
nnoremap <leader>gp  : Git push origin master
nnoremap <leader>gl  : Gclog<cr>
nnoremap <leader>gd  : Git diff<cr>
nnoremap <leader>gdv : Gvdiffsplit<cr><A-l>
nnoremap <leader>gds : Gdiffsplit<cr><A-l>
nnoremap <leader>gdt : Git difftool<cr>
nnoremap <leader>gs  : Git status<cr>
nnoremap <leader>gm  : Git merge<cr>
nnoremap <leader>gmt : Git mergetool<cr>
nnoremap <leader>gd  : GDelete<cr>
nnoremap <leader>gb  : GBrowse<cr>

" Compilations hotkeys
" autocmd filetype python     map <F2> :w<CR>:vsplit term://python3 %<CR><C-w>L
" autocmd filetype cpp        map <F2> :w<CR>:vsplit term://g++ -std=c++14 % && ./a.out<CR><C-w>L
" autocmd filetype java       map <F2> :w<CR>:vsplit term://javac % && java %:r <CR><C-w>L
" autocmd filetype javascript map <F2> :w<CR>:vsplit term://node % <CR><C-w>L
" autocmd filetype kotlin     map <F2> :w<CR>:vsplit term://kotlinc % -include-runtime -d a.jar && java -jar a.jar<CR><C-w>L

" ToggleTerm
autocmd filetype java       map <F2> :w<CR>:2TermExec direction=float hide=1 cmd="javac % && java %:r"<CR>
autocmd filetype cpp        map <F2> :w<CR>:2TermExec direction=float hide=1 cmd="g++ -std=c++14 % && ./a.out"<CR>
autocmd filetype python     map <F2> :w<CR>:2TermExec direction=float hide=1 cmd="python3 %"<CR>
autocmd filetype javascript map <F2> :w<CR>:2TermExec direction=float hide=1 cmd="node %"<CR>
autocmd filetype kotlin     map <F2> :w<CR>:2TermExec direction=float hide=1 cmd="kotlinc % -include-runtime -d a.jar && java -jar a.jar"<CR>

" Todo plugin hotkey
nnoremap <leader>N :TodoQuickFix<CR>

" Easy align plugin
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Command mode next/previous 
cnoremap <C-j> <Down>
cnoremap <C-K> <Up>

" Easy Motion
let g:EasyMotion_smartcase = 1  " Case insensitive unless uppercase is used
let g:EasyMotion_use_smartsign_us = 1 " Smarter character matching
nmap <leader>,, <Plug>(easymotion-overwin-f2)

" Find in File explorer
nmap <F1> :NvimTreeFindFileToggle<CR>


nnoremap gs :SymbolsOutline<cr>


lua << EOF
-- Telescope keymap
local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

-- 🔹 Find files & general Telescope mappings
vim.keymap.set('n', '<Space><Space>', builtin.builtin, opts)
vim.keymap.set('n', '<leader>f', function()
  require('telescope.builtin').find_files({
    previewer = false,
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.4,
      height = 0.4,
    },
  })
end, opts)

vim.keymap.set('n', '<leader>r', builtin.live_grep, opts)

vim.keymap.set('n', '<leader>b', function()
  require('telescope.builtin').buffers({
    previewer = false,
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.4,
      height = 0.4,
    },
  })
end, opts)

vim.keymap.set('n', '<leader><Tab>', builtin.oldfiles, opts)
vim.keymap.set('n', '<leader>gt', builtin.treesitter, opts)
vim.keymap.set('n', '<leader>c', builtin.commands, opts)
vim.keymap.set('n', '<leader>j', builtin.jumplist, opts)
vim.keymap.set('n', '<leader>m', builtin.marks, opts)
vim.keymap.set('n', '<leader>M', builtin.keymaps, opts)
vim.keymap.set('n', '<leader>H', builtin.help_tags, opts)

-- 🔹 LSP Pickers (Direct Keybindings)
vim.keymap.set("n", "gR", function() builtin.lsp_references() end, opts)
vim.keymap.set("n", "<leader>ld", function() builtin.lsp_document_symbols() end, opts)
vim.keymap.set("n", "<leader>lw", function() builtin.lsp_workspace_symbols() end, opts)
vim.keymap.set("n", "<leader>ls", function() builtin.lsp_dynamic_workspace_symbols() end, opts)
vim.keymap.set("n", "<leader>lI", function() builtin.lsp_implementations() end, opts)

-- 🔹 LSP Diagnostics (Handled Separately)
vim.keymap.set("n", "<leader>lx", function() builtin.diagnostics({ bufnr = 0 }) end, opts)  -- Current buffer diagnostics
vim.keymap.set("n", "<leader>P", builtin.diagnostics, opts)  -- All buffers diagnostics

-- grep selected text
vim.keymap.set("v", "<leader>r", function()
    vim.cmd('normal! "zy') -- Copy selection to register z
    local selected_text = vim.fn.getreg("z") -- Get selected text
    selected_text = selected_text:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "\\%1") -- Escape only regex special characters for Ripgrep
    selected_text = selected_text:gsub("\n", " ") -- Convert newlines to spaces (Fix for multi-line selection)

    builtin.live_grep({ default_text = selected_text })
end, { noremap = true, silent = true })



-- LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- TypeScript: Organize Imports
    vim.keymap.set("n", "<Space>oi", function()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
    end, opts)

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)

    -- Hover / Signature
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<Space>k", vim.lsp.buf.signature_help, opts)

    -- Code Actions / Rename
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set("n", "[[", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]]", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>p", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)

    -- Formatting
    vim.keymap.set("n", "<Space>f", function()
        vim.lsp.buf.format { async = true }
    end, opts)

    -- Inlay Hints Toggle (if supported)
    if vim.lsp.inlay_hint then
        vim.keymap.set("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, opts)
    end
end,
})

EOF
