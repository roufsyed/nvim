-- Indent guide lines
-- Highlight colors: #3b3b3b, #515151
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#515151", nocombine = true })
require("ibl").setup {
	indent = {
		char = "│",
		highlight = "IndentBlanklineChar",
	}
}
