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
        -- ✅ Configure diagnostics globally
        vim.diagnostic.config({
            virtual_text = true,  -- Show inline diagnostics
            signs = true,         -- Show signs in gutter
            update_in_insert = false,
            underline = true,
            severity_sort = true,
        })

        local opts = { noremap = true, silent = true, buffer = event.buf }

        vim.keymap.set("n", "<Space>oi", function()
            local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) } }
            vim.lsp.buf.execute_command(params)
        end, opts)

        -- 🔹 LSP Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<Space>ws", vim.lsp.buf.workspace_symbol, opts)

        -- 🔹 Hover & Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<Space>k", vim.lsp.buf.signature_help, opts)

        -- 🔹 Code Actions & Refactoring
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)

        -- 🔹 Diagnostics
        vim.keymap.set("n", "[[", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]]", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>p", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, opts)

        -- 🔹 Formatting
        vim.keymap.set("n", "<Space>f", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- 🔹 Workspace Management
        vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<Space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        -- 🔹 Toggle Inlay Hints (if supported)
        if vim.lsp.inlay_hint then
            vim.keymap.set("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, opts)
        end
    end,
})
