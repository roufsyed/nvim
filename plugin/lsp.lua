require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls", "ts_ls", "gopls", "rust_analyzer", "html", "cssls", "jdtls", "kotlin_language_server"
	} -- Add LSPs you need
}

local lspconfig = require("lspconfig")

-- Auto-configure installed LSP servers
require("mason-lspconfig").setup_handlers {
	function(server)
		lspconfig[server].setup {}
	end
}



local opts = { noremap = true, silent = true }

-- 🔹 LSP Navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)               -- Go to definition
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)              -- Go to declaration
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)           -- Go to implementation
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)               -- Find references
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)   -- Go to type definition
vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts) -- Search workspace symbols

-- 🔹 Hover & Documentation
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)              -- Show documentation on hover
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Show function signature help

-- 🔹 Code Actions & Refactoring
vim.keymap.set("n", "<D-Space>", vim.lsp.buf.code_action, opts) -- Cmd + Space (macOS)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)     -- Rename symbol

-- 🔹 Diagnostics & Error Handling
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)        -- Jump to previous diagnostic
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)        -- Jump to next diagnostic
vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float, opts) -- Show diagnostics in a popup
vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist, opts) -- Add diagnostics to quickfix list

-- 🔹 Formatting & Organizing Imports
vim.keymap.set("n", "<Space>f", function() vim.lsp.buf.format { async = true } end, opts) -- Format buffer
vim.keymap.set("n", "<Space>oi", function() vim.lsp.buf.execute_command({ command = "_typescript.organizeImports" }) end,
	opts)                                                                                 -- Organize imports (TypeScript-specific)

-- 🔹 Workspace & Project Management
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)    -- Add workspace folder
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts) -- Remove workspace folder
vim.keymap.set("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts) -- List workspace folders

-- 🔹 Symbol Navigation (Treesitter-like behavior)
vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)  -- List document symbols
vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts) -- Search workspace symbols

-- 🔹 Toggle Inlay Hints (if supported by LSP)
if vim.lsp.buf.inlay_hint then
	vim.keymap.set("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, opts) -- Toggle inlay hints
end
