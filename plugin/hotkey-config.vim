"----------------------------------------------------------------------------------------------------------------------------------------------
"Hotkey configurations
"-----------------------------------------------------------------------------------------------------------------------------------------------

"remap to jj to esc and to get into normal mode in terminal
imap jj <Esc>
tnoremap jj <C-\><C-n>

" Specific to toggleterm plugin
" nmap <silent><leader>T :ToggleTerm direction=horizontal size=12 hide=1<CR>
" tnoremap <silent><leader>T :ToggleTerm hide<CR>

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
nnoremap C Vy

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
" vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
" vnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap s y:let @/ = escape(@", '/\')<CR>:set hlsearch<CR>
nnoremap s :call SearchWithoutJump()<CR>

function! SearchWithoutJump()
  let l:search = input('/')
  if !empty(l:search)
    let @/ = escape(l:search, '/\')
    set hlsearch
  endif
endfunction

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

" Ripgrep and through result in quickfix list
" nnoremap <leader>F :call ProjectSearch()<CR>

"to open init and source
function! Init()
    cd ~/.config/nvim/
    :e init.vim
endfunction

nnoremap <silent><F8> :call Init()<cr>
nnoremap ss :source %<CR>

" Redo
nnoremap U :redo<cr>

" File explorer
nnoremap <silent><leader>e :NvimTreeFindFileToggle<cr>

" opens a new tab
nnoremap <silent><leader>t :tabnew<cr>
nnoremap <silent><leader>v :vsp<cr>
nnoremap <silent><leader>h :sp<cr>

" Quickfix list: cnext, cprevious and copen
nmap <Up> :copen<cr>
nmap <Down> :cclose<cr>
nmap <Right> :cnext<cr>
nmap <Left> :cprevious<cr>

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
nnoremap <leader>gdv : Gvdiffsplit<cr><A-l>
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
autocmd filetype java       map <F2> :w<CR>:2TermExec direction=horizontal hide=1 cmd="javac % && java %:r"<CR>
autocmd filetype cpp        map <F2> :w<CR>:2TermExec direction=horizontal hide=1 cmd="g++ -std=c++14 % && ./a.out"<CR>
autocmd filetype python     map <F2> :w<CR>:2TermExec direction=horizontal hide=1 cmd="python3 %"<CR>
autocmd filetype javascript map <F2> :w<CR>:2TermExec direction=horizontal hide=1 cmd="node %"<CR>
autocmd filetype kotlin     map <F2> :w<CR>:2TermExec direction=horizontal hide=1 cmd="kotlinc % -include-runtime -d a.jar && java -jar a.jar"<CR>

" (todo-comments.nvim removed; :TodoQuickFix no longer exists)

" Easy align plugin
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Command mode next/previous 
cnoremap <C-j> <Down>
cnoremap <C-K> <Up>

" Easy Motion
" let g:EasyMotion_smartcase = 1  " Case insensitive unless uppercase is used
" let g:EasyMotion_use_smartsign_us = 1 " Smarter character matching
" nmap <leader>,, <Plug>(easymotion-overwin-f2)

" Find in File explorer
nmap <F1> :NvimTreeFindFileToggle<CR>

" Outline
nnoremap gs :Outline<cr>

" for movement multi-line
nnoremap j gj
nnoremap k gk

xnoremap j gj
xnoremap k gk



lua << EOF
-- Telescope keymap
local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

-- File type based search and remembers last searched 
local last_search_extension = ""
local last_pattern_searched = ""

local function find_files_by_extension()
  vim.ui.input({
    prompt = 'Enter file extension (e.g. js, java): ',
    default = last_search_extension,  -- Prefill with the last search extension
  }, function(input)
    if input then
      -- If input is not empty, save the last search extension
      if input ~= "" then
        last_search_extension = input
      end

      -- Determine the search pattern based on whether input is empty or not
      local pattern = input ~= "" and "*." .. input or "*.*"  -- Search for all files if input is empty

      -- Perform the search
      builtin.find_files({
        prompt_title = 'Find Files: ' .. (input ~= "" and "*." .. input or "All Files"),
        find_command = { 'rg', '--files', '--glob', pattern },
        previewer = false,
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.4,
          height = 0.4,
        },
      })
    else
      print('No input provided')
    end
  end)
end

vim.keymap.set("n", "<leader>F", find_files_by_extension, opts)

-- 🔹 Find files & general Telescope mappings
vim.keymap.set('n', '<Space><Space>', builtin.builtin, opts)
vim.keymap.set('n', '<leader>R', ':Telescope registers<CR>', opts)

-- Function to store the last searched file pattern and use it in the next search
vim.keymap.set('n', '<leader>f', function()
    require('telescope.builtin').find_files({
      prompt_title = "Search for File",
      previewer = false,
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.4,
        height = 0.4,
      },
    })
  end)

-- multigrep, can pass file type (*.vim) after 2 spaces
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job {
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = { "rg" }
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end

			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end

			-- vim.tbl_flatten is deprecated and removed in Nvim 0.13
			return vim.iter({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			}):flatten():totable()
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	}

	pickers.new(opts, {
		debounce = 100,
		prompt_title = "Multi Grep",
		finder = finder,
		previewer = conf.grep_previewer(opts),
		sorter = require("telescope.sorters").empty(),
	}):find()
end

vim.keymap.set("n", "<leader>r", live_multigrep, opts)

-- IntelliJ "Find in Path" = Cmd+Shift+F. macOS terminals never deliver Cmd to
-- the TTY, so wezterm.lua binds Cmd+Shift+F to the F17 escape sequence
-- (kf17 = \E[15;2~) and we listen for that here. See ~/.config/wezterm/wezterm.lua.
vim.keymap.set("n", "<F17>", live_multigrep, opts)

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

-- grep selected text project-wide (IntelliJ: select, then Cmd+Shift+F)
local function grep_selection()
    vim.cmd('normal! "zy') -- Copy selection to register z
    local selected_text = vim.fn.getreg("z") -- Get selected text
    selected_text = selected_text:gsub("([%(%)%.%+%-%*%?%[%]%^%$])", "\\%1") -- Escape only regex special characters for Ripgrep
    selected_text = selected_text:gsub("\n", " ") -- Convert newlines to spaces (Fix for multi-line selection)

    builtin.live_grep({ default_text = selected_text })
end

vim.keymap.set("v", "<leader>r", grep_selection, { noremap = true, silent = true })
vim.keymap.set("v", "<F17>", grep_selection, { noremap = true, silent = true })



-- LSP keymap
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- TypeScript: Organize Imports
    vim.keymap.set("n", "<Space>o", function()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
    end, opts)

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)

    -- Hover / Signature
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<Space>k", vim.lsp.buf.signature_help, opts)

    -- Code Actions / Rename
    -- vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<Space>r", vim.lsp.buf.rename, opts)

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


-- Trouble
-- Open Trouble with diagnostics
vim.keymap.set("n", "<leader>P", function()
  require("trouble").open("diagnostics")
end, { noremap = true, silent = true })

-- Open Trouble with symbols
vim.keymap.set("n", "<leader>S", function()
  require("trouble").open("symbols")
end, { noremap = true, silent = true })

vim.keymap.set("n", "gr", function()
  require("trouble").open("lsp_references")
end, { noremap = true, silent = true })


-- Run current Java file using javac + java in split terminal
vim.keymap.set("n", "<F10>", function()
  local file = vim.fn.expand("%:t")        -- Main.java
  local classname = vim.fn.expand("%:t:r") -- Main

  vim.cmd("botright split | resize 20 | terminal")

  vim.fn.chansend(vim.b.terminal_job_id,
    "javac " .. file .. " && java " .. classname .. "\n"
  )
  vim.cmd("startinsert")
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>T", function()
  vim.cmd("botright split | resize 12 | terminal")
  vim.cmd("startinsert")
end, { noremap = true, silent = true })


-- code Action Preview 
vim.keymap.set({ "v", "n" }, "<leader>a", require("actions-preview").code_actions)


-- Competitive Coding test run
vim.keymap.set("n", "<F4>", "<cmd>CompetiTest run<CR>", { desc = "Run Competitest testcases" })


vim.keymap.set("n", "<F5>", "<cmd>CompetiTest add_testcase<CR>", { desc = "Add new Competitest testcase" })
vim.keymap.set("n", "<F6>", "<cmd>CompetiTest edit_testcase<CR>", { desc = "Edit Competitest testcase" })

EOF
