-- LSP setup for Neovim 0.12 (native vim.lsp.config / vim.lsp.enable API).
--
-- The old `require('lspconfig').<name>.setup{}` path is gone. mason-lspconfig v2
-- auto-enables every installed server, so all we do here is REGISTER config per
-- server name -- whoever enables it picks that config up.

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls", "rust_analyzer", "clangd",
		"lua_ls", "ts_ls", "html", "cssls", "jdtls", "kotlin_language_server",
		"pyright", "jsonls", "yamlls", "bashls",
	},
	-- jdtls is still installed by Mason, but nvim-jdtls starts it itself from
	-- ftplugin/java.lua with per-project workspaces and the extended client
	-- capabilities. Letting mason-lspconfig auto-enable it too would put two
	-- jdtls servers on every Java buffer.
	automatic_enable = { exclude = { "jdtls" } },
})

----------------------------------------------------------------------
-- Defaults applied to every server
----------------------------------------------------------------------
vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

----------------------------------------------------------------------
-- Go
----------------------------------------------------------------------
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
			semanticTokens = true,
			hoverKind = "FullDocumentation",
			-- Keeps indexing sane on large repos.
			directoryFilters = { "-.git", "-node_modules", "-vendor", "-bazel-out" },
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
				fieldalignment = false, -- noisy on real codebases
			},
			codelenses = {
				generate = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				regenerate_cgo = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

----------------------------------------------------------------------
-- Rust
----------------------------------------------------------------------
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			-- `checkOnSave` is a boolean now; the command moved to `check.command`.
			-- The old nested `checkOnSave = { command = ... }` form is ignored.
			checkOnSave = true,
			check = {
				command = "clippy",
				extraArgs = { "--all-targets", "--all-features" },
			},
			cargo = {
				allFeatures = true,
				buildScripts = { enable = true },
			},
			procMacro = {
				enable = true,
				ignored = { ["async-trait"] = { "async_trait" }, ["napi-derive"] = { "napi" } },
			},
			files = { excludeDirs = { ".git", "target", "node_modules" } },
			inlayHints = {
				bindingModeHints = { enable = false },
				closureReturnTypeHints = { enable = "with_block" },
				parameterHints = { enable = true },
				typeHints = { enable = true },
			},
			diagnostics = {
				enable = true,
				disabled = { "unresolved-proc-macro" },
			},
		},
	},
})

----------------------------------------------------------------------
-- C / C++
----------------------------------------------------------------------
-- clangd needs a compile_commands.json to be useful on a real project.
-- CMake: -DCMAKE_EXPORT_COMPILE_COMMANDS=ON   Make: use `bear -- make`.
--
-- `cmd` resolves "clangd" through nvim's PATH, which Mason prepends -- so this
-- picks up Mason's clangd (currently 22.x) and falls back to Apple's
-- /usr/bin/clangd (17.x) if Mason's is ever missing.
vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
		"--pch-storage=memory",
		"--all-scopes-completion",
		"-j=4",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
})

----------------------------------------------------------------------
-- Everything else
----------------------------------------------------------------------
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = { callSnippet = "Both" },
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("ts_ls", { -- was `tsserver`, which no longer matches any server
	settings = {
		typescript = {
			preferences = {
				importModuleSpecifierPreference = "non-relative",
				includeCompletionsForImportStatements = true,
				quotePreference = "auto",
			},
		},
	},
})

-- jdtls is configured in ftplugin/java.lua, via nvim-jdtls.

vim.lsp.config("pyright", {
	settings = {
		python = { analysis = { autoImportCompletions = true, typeCheckingMode = "basic" } },
	},
})

vim.lsp.config("yamlls", {
	settings = { yaml = { schemas = { kubernetes = "/*.k8s.yaml" }, validate = true } },
})

vim.lsp.config("cssls", {
	settings = { css = { validate = true, lint = { unknownAtRules = "ignore" } } },
})

vim.lsp.config("html", {
	settings = {
		html = { hover = { documentation = true, references = true }, completion = { autoClosingTags = true } },
	},
})

vim.lsp.config("bashls", {
	settings = { bashIde = { globPattern = "*@(.sh|.inc|.bash|.command)" } },
})

vim.lsp.config("kotlin_language_server", {
	settings = { kotlin = { completion = { snippets = true }, analysis = { server = true } } },
})

----------------------------------------------------------------------
-- Enable explicitly
----------------------------------------------------------------------
-- mason-lspconfig only auto-enables servers IT installed. Go/Rust/C++ toolchains
-- are installed outside Mason here (go install, rustup, Apple clangd), so enable
-- them by hand -- otherwise clangd in particular never starts.
vim.lsp.enable({ "gopls", "rust_analyzer", "clangd" })

----------------------------------------------------------------------
-- Per-buffer wiring (replaces the on_attach that never ran)
----------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end

		vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Isolated so one failure cannot stop the rest of the attach.
		if client:supports_method("textDocument/inlayHint") then
			pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
		end

		-- Automatic signature help, without lsp_signature.nvim.
		--
		-- Servers advertise which characters should trigger/retrigger it ("(" and
		-- "," for most languages), so we watch for exactly those rather than
		-- firing a request on every keystroke. vim.lsp.buf.signature_help sets
		-- focus_id internally, so repeat calls REPLACE the float instead of
		-- stacking new ones. Manual <C-s> in insert mode still works as well.
		local sig = client.server_capabilities.signatureHelpProvider
		if sig then
			local triggers = {}
			for _, c in ipairs(sig.triggerCharacters or {}) do triggers[c] = true end
			for _, c in ipairs(sig.retriggerCharacters or {}) do triggers[c] = true end

			if next(triggers) then
				vim.api.nvim_create_autocmd("TextChangedI", {
					group = vim.api.nvim_create_augroup("lsp_sig_" .. args.buf, { clear = true }),
					buffer = args.buf,
					desc = "Auto signature help on LSP trigger characters",
					callback = function()
						-- Don't fight the completion menu for screen space.
						local has_cmp, cmp = pcall(require, "cmp")
						if vim.fn.pumvisible() == 1 or (has_cmp and cmp.visible()) then
							return
						end

						local col = vim.api.nvim_win_get_cursor(0)[2]
						local char = vim.api.nvim_get_current_line():sub(col, col)
						if triggers[char] then
							vim.lsp.buf.signature_help({
								focusable = false,
								close_events = { "InsertLeave", "BufHidden", "CursorMoved" },
							})
						end
					end,
				})
			end
		end
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

vim.api.nvim_create_user_command("InlayHints", function()
	local on = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not on, { bufnr = 0 })
end, { desc = "Toggle inlay hints for this buffer" })

----------------------------------------------------------------------
-- Format on save
----------------------------------------------------------------------
-- Keyed on FILETYPE. The old version globbed "*." .. filetype, so `*.rust`,
-- `*.python`, `*.typescriptreact` etc. matched no real file and never fired.
local format_with = {
	go = "gopls",
	rust = "rust_analyzer",
	c = "clangd",
	cpp = "clangd",
	objc = "clangd",
	lua = "lua_ls",
	java = "jdtls",
	html = "html",
	css = "cssls",
	scss = "cssls",
	less = "cssls",
	json = "jsonls",
	yaml = "yamlls",
	sh = "bashls",
	typescript = "ts_ls",
	typescriptreact = "ts_ls",
	javascript = "ts_ls",
	javascriptreact = "ts_ls",
}

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true }),
	callback = function(args)
		local server = format_with[vim.bo[args.buf].filetype]
		if not server then return end

		-- Go: fix up imports first, the way goimports would.
		if vim.bo[args.buf].filetype == "go" then
			local params = vim.lsp.util.make_range_params(0, "utf-8")
			params.context = { only = { "source.organizeImports" }, diagnostics = {} }
			local res = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1500)
			for _, r in pairs(res or {}) do
				for _, action in pairs(r.result or {}) do
					if action.edit then
						vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
					end
				end
			end
		end

		vim.lsp.buf.format({
			async = false,
			bufnr = args.buf,
			timeout_ms = 3000,
			filter = function(c) return c.name == server end,
		})
	end,
})

----------------------------------------------------------------------
-- Swift (no lspconfig entry; started by hand)
----------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "swift", "objective-c", "objective-cpp" },
	callback = function()
		local sourcekit = "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp"
		if vim.fn.executable(sourcekit) == 0 then return end
		vim.lsp.start({
			name = "sourcekit",
			cmd = { sourcekit },
			root_dir = vim.fs.root(0, { "Package.swift", ".git" }) or vim.fn.getcwd(),
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
})
