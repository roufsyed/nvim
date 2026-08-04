require("mason").setup()

require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls", "ts_ls", "rust_analyzer", "html", "cssls", "jdtls", "kotlin_language_server",
		"pyright", "jsonls", "yamlls", "bashls", "gopls"
	}
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <C-x><C-o>
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	local buf_map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
	end

	-- Signature help if supported
	if client.server_capabilities.signatureHelpProvider then
		require("lsp_signature").on_attach({
			bind = true,
			hint_enable = true,
			handler_opts = { border = "rounded" },
		}, bufnr)
	end
end


local servers = {
	gopls = {
		settings = {
			gopls = {
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				analyses = {
					unusedparams = true,
					shadow = true,
				},
				gofumpt = true,
				hoverKind = "FullDocumentation",
			}
		}
	},
	lua_ls = {
		settings = {
			Lua = {
				completion = { callSnippet = "Both" },
				diagnostics = { globals = { "vim" } },
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			}
		}
	},
	tsserver = {
		settings = {
			typescript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					includeCompletionsForImportStatements = true,
					quotePreference = "auto",
				}
			}
		}
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
				rustfmt = { enableRangeFormatting = true },
				diagnostics = {
					enable = true,
					disabled = { "unresolved-proc-macro" },
				},
				cargo = {
					allFeatures = true,
				},
			}
		}
	},
	jdtls = {
		settings = {
			java = {
				format = { enabled = true },
				saveActions = { organizeImports = true },
				completion = {
					favoriteStaticMembers = {
						"java.lang.Math.*",
						"java.util.Objects.requireNonNull",
						"java.util.stream.Collectors.toList",
					}
				},
			}
		}
	},
	kotlin_language_server = {
		settings = {
			kotlin = {
				completion = { snippets = true },
				analysis = { server = true },
			}
		}
	},
	html = {
		settings = {
			html = {
				hover = { documentation = true, references = true },
				completion = { autoClosingTags = true },
			}
		}
	},
	cssls = {
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			}
		}
	},
	yamlls = {
		settings = {
			yaml = {
				schemas = {
					kubernetes = "/*.k8s.yaml",
				},
				validate = true,
			}
		}
	},
	bashls = {
		settings = {
			bashIde = {
				globPattern = "*@(.sh|.inc|.bash|.command)",
			}
		}
	},
	pyright = {
		settings = {
			python = {
				analysis = {
					autoImportCompletions = true,
					typeCheckingMode = "basic",
				},
			}
		}
	},
}

local mlsp = require("mason-lspconfig")

-- New nvim 0.11+ LSP config loading
local function setup_server(server)
	local cfg = vim.lsp.config[server] -- nil if server does NOT exist in new API

	if not cfg or not cfg.setup then
		-- Skip servers like jdtls or sourcekit that do not use setup()
		return
	end

	local opts = vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, servers[server] or {})

	cfg.setup(opts)
end

-- mason-lspconfig ≥ 1.20 uses setup_handlers
if mlsp.setup_handlers then
	mlsp.setup_handlers({
		function(server)
			setup_server(server)
		end
	})

	-- fallback for older mason-lspconfig versions
else
	for _, server in ipairs(mlsp.get_installed_servers()) do
		setup_server(server)
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
		})
	end,
})

-- Map LSP names to filetypes
local lsp_format_filetypes = {
	gopls = { "go" },
	lua_ls = { "lua" },
	tsserver = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	rust_analyzer = { "rust" },
	html = { "html" },
	cssls = { "css", "scss", "less" },
	jdtls = { "java" },
	kotlin_language_server = { "kotlin" },
	pyright = { "python" },
	jsonls = { "json" },
	bashls = { "sh" },
	yamlls = { "yaml" },
}

-- Format on save
for lsp_name, filetypes in pairs(lsp_format_filetypes) do
	for _, ft in ipairs(filetypes) do
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*." .. ft,
			callback = function()
				-- local clients = vim.lsp.get_active_clients({ bufnr = 0 })
				local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
				for _, client in ipairs(clients) do
					if client.name == lsp_name and client.server_capabilities.documentFormattingProvider then
						vim.lsp.buf.format({
							async = false,
							filter = function(format_client)
								return format_client.name == lsp_name
							end,
						})
						return
					end
				end
			end,
		})
	end
end

-- Swift LSP config
local capabilities = capabilities -- from your existing config
local on_attach = on_attach       -- from your existing config

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "swift", "objective-c", "objective-cpp" },
	callback = function()
		vim.lsp.start({
			name = "sourcekit",
			cmd = { "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp" },
			root_dir = vim.fs.root(0, { "Package.swift", ".git" }) or vim.fn.getcwd(),
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
})
