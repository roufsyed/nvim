require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "cpp", "java", "python", "kotlin", "html", "css", "javascript", "json", "bash", "graphql", "lua", "php", "typescript", "yaml", "vue", "vim", "dockerfile", "tsx", "r", "query" },

    highlight = {
        enable = true,
        custom_captures = {
            ["<capture group>"] = "<highlight group>",
            ["keyword"] = "TSString",
        },
    },

    indent = {
        enable = true
    },
})
