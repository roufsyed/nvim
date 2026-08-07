-- nvim-treesitter `main` branch (the 2026 rewrite).
--
-- The old `require('nvim-treesitter.configs').setup{...}` API is gone: `main`
-- only installs parsers and ships queries. Highlighting, indentation and folds
-- are Neovim features now, and nothing is enabled automatically -- we turn them
-- on per-buffer in the FileType autocmd below.
--
-- Requires the tree-sitter CLI (>= 0.26.1) on PATH: `brew install tree-sitter-cli`.
-- Run `:TSUpdate` after the plugin itself updates, or parsers drift out of sync
-- with the bundled queries.

local ts = require("nvim-treesitter")

ts.setup({
	-- Parsers/queries land here, prepended to runtimepath so they win over
	-- the ones Neovim bundles.
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- The parsers this config wants. Declared, but NOT installed on startup:
-- `install()` logs "Downloading ..." for every missing parser on every launch,
-- and stalls if the download cannot reach GitHub. Run `:TSSyncParsers` to
-- install whatever is missing.
local wanted = {
	"bash", "c", "cpp", "css", "dockerfile", "go", "graphql", "html",
	"java", "javascript", "json", "kotlin", "latex", "lua", "php",
	"python", "query", "r", "rust", "tsx", "typescript", "vim", "vue", "yaml",
	-- build/config files that ride along with go, rust and c++ work
	"gomod", "gosum", "gowork", "cmake", "make", "toml", "proto",
}

vim.api.nvim_create_user_command("TSSyncParsers", function()
	local installed = {}
	for _, l in ipairs(ts.get_installed()) do installed[l] = true end

	local missing = vim.tbl_filter(function(l) return not installed[l] end, wanted)
	if #missing == 0 then
		vim.notify("treesitter: all " .. #wanted .. " parsers present", vim.log.levels.INFO)
		return
	end

	vim.notify("treesitter: installing " .. table.concat(missing, ", "), vim.log.levels.INFO)
	ts.install(missing)
end, { desc = "Install any declared treesitter parsers that are missing" })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_enable", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		-- `language.add` returns nil (it does not throw) when no parser is
		-- installed for this filetype -- leave those buffers on vim regex syntax.
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start(args.buf, lang)
		-- Treesitter indentation is still flagged experimental upstream.
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Note: `incremental_selection` (gnn/grn/grc/grm) was removed upstream with no
-- replacement, so those mappings are gone. That also hands `grn` back to
-- Neovim's built-in LSP rename.
