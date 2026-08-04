local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Only confirm if explicitly selected
		["<C-e>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
	},

	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
	}),

	preselect = cmp.PreselectMode.None,

	completion = {
		completeopt = 'menu,menuone,noinsert',
	},

	window = {
		completion = { max_height = 10 },
		documentation = { max_height = 15, max_width = 60 },
	},
})

if not cmp.cmdline_setup_done then
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline({
			['<CR>'] = cmp.mapping.confirm({ select = false }),
		}),
		sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
		preselect = cmp.PreselectMode.None,
		completion = { completeopt = 'menu,menuone,noinsert,noselect' },
	})

	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline({
			['<CR>'] = cmp.mapping.confirm({ select = false }),
		}),
		sources = { { name = 'buffer' } },
		preselect = cmp.PreselectMode.None,
		completion = { completeopt = 'menu,menuone,noinsert,noselect' },
	})

	cmp.cmdline_setup_done = true
end

-- LSP capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
	"gopls",
	"ts_ls",
	"rust_analyzer",
	"html",
	"cssls",
	"jdtls",
	"sourcekit",
}

for _, name in ipairs(servers) do
	local cfg = vim.lsp.config[name] -- nil if server does NOT exist
	if cfg and cfg.setup then     -- safe-guard: only load valid servers
		cfg.setup({
			capabilities = capabilities,
		})
	end
end
