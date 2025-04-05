require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "ts_ls", "rust_analyzer", "html", "cssls", "jdtls", "kotlin_language_server" } -- Add LSPs you need
}


local lspconfig = require("lspconfig")

-- Load capabilities for better completion support
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local common_settings = {
    capabilities = capabilities,
    settings = {
        gopls = {
            usePlaceholders = true,  -- Show placeholders in function calls
            completeUnimported = true,  -- Suggest and auto-import missing packages
            staticcheck = true,  -- Enable static analysis
            analyses = {
                unusedparams = true,  -- Warn about unused parameters
                shadow = true,  -- Detect shadowed variables
            },
            hoverKind = "FullDocumentation", -- Show detailed hover info
        },
        lua_ls = {
            Lua = {
                completion = { callSnippet = "Both" },  -- Show function parameters in completion
                diagnostics = { globals = { "vim" } },  -- Ignore 'vim' global warnings
                workspace = { checkThirdParty = false },  -- Speed up LSP by ignoring third-party libraries
                telemetry = { enable = false },  -- Disable telemetry
            },
        },
        tsserver = {
            preferences = {
                importModuleSpecifierPreference = "non-relative",  -- Prefer absolute imports
                includeCompletionsForImportStatements = true,  -- Suggest imports in completion
                quotePreference = "auto",  -- Use single/double quotes automatically
            },
        },
        rust_analyzer = {
            checkOnSave = { command = "clippy" },  -- Run Clippy on save
            rustfmt = { enableRangeFormatting = true },  -- Enable range formatting
            diagnostics = {
                enable = true, -- Enable diagnostics
                disabled = { "unresolved-proc-macro" },  -- Ignore specific warnings
            },
            cargo = {
                allFeatures = true,  -- Enable all features for cargo check
            },
        },
        jdtls = {
            java = {
                format = { enabled = true },  -- Enable formatting
                saveActions = { organizeImports = true },  -- Organize imports on save
                completion = {
                    favoriteStaticMembers = {
                        "java.lang.Math.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.stream.Collectors.toList",
                    },  -- Prioritize frequently used imports
                },
            },
        },
        kotlin_language_server = {
            kotlin = {
                completion = { snippets = true },  -- Enable snippets
                analysis = { server = true },  -- Enable Kotlin static analysis
            },
        },
        html = {
            hover = { documentation = true, references = true },  -- Show documentation on hover
            completion = { autoClosingTags = true },  -- Auto-close HTML tags
        },
        cssls = {
            validate = true,  -- Enable validation for CSS files
            lint = {
                unknownAtRules = "ignore",  -- Ignore unknown @rules
            },
        },
        yamlls = {
            yaml = {
                schemas = {
                    kubernetes = "/*.k8s.yaml",  -- Kubernetes schema for YAML files
                },
                validate = true,  -- Enable validation
            },
        },
        bashls = {
            bashIde = {
                globPattern = "*@(.sh|.inc|.bash|.command)",  -- Recognize shell script files
            },
        },
        pyright = {
            python = {
                analysis = {
                    autoImportCompletions = true,  -- Suggest auto-imports
                    typeCheckingMode = "basic",  -- Enable basic type checking
                },
            },
        },
    }
}

require("mason-lspconfig").setup_handlers {
  function(server)
    lspconfig[server].setup {
		capabilities = capabilities,
	}
  end
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        -- Global diagnostic config (not buffer-specific)
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
        })

    end,
})
