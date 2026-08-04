local null_ls = require("null-ls")

-- Register only what you want manually
null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown", "css" },
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.formatting.goimports_reviser,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "markdown" }
		}),
	},
	on_attach = function(client, bufnr)
		-- Prevent autoformat on save unless explicitly enabled per buffer
		client.server_capabilities.documentFormattingProvider = false
	end,
})


vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ timeout_ms = 2000 })
end, {})
