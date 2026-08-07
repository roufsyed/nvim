local null_ls = require("null-ls")

-- null-ls only covers languages whose LSP does NOT format.
-- Go -> gopls (gofumpt), Rust -> rust-analyzer (rustfmt), C/C++ -> clangd
-- (clang-format) all format themselves, so they are deliberately absent here.
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown", "css" },
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.black,
	},
	-- NOTE: the previous config set `documentFormattingProvider = false` in
	-- on_attach, which disabled null-ls formatting outright -- stylua, black and
	-- shfmt never ran. Format-on-save is scoped by filetype in lsp.lua instead.
})

vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ timeout_ms = 3000 })
end, { desc = "Format buffer with any capable client" })
