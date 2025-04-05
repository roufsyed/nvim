local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- Use LuaSnip for snippets
        end,
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm selection manually
        ["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
		["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate to next item
        ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navigate to previous item
        ["<C-n>"] = cmp.mapping.select_next_item(), -- Navigate to next item
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- Navigate to previous item
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- LSP completion
        { name = 'luasnip' },   -- Snippet completion
        { name = 'buffer' },    -- Buffer completion
        { name = 'path' },      -- File path completion
    })
})

-- Set configuration for command-line completion
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- Enable language servers
local servers = { "gopls", "ts_ls", "rust_analyzer", "html", "cssls", "jdtls" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,  -- Ensure LSP servers support nvim-cmp
    }
end

