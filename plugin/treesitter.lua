require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "java", "python", "kotlin", "html", "css", "javascript", "json", "bash", "graphql", "lua", "php", "typescript", "yaml", "vue", "vim", "dockerfile", "tsx", "r", "query" },

    highlight = {
        enable = true,
        custom_captures = {
            ["<capture group>"] = "<highlight group>",
            ["keyword"] = "tsstring",
        },
    },
    
    -- incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --       init_selection = "gnn",
    --       node_incremental = "grn",
    --       scope_incremental = "grc",
    --       node_decremental = "grm",
    --     },
    --   },

    indent = {
        enable = true
    },
})
