-- Using catgoose/nvim-colorizer.lua: norcalli's original has been unmaintained
-- since 2021 and still calls vim.tbl_flatten, which Nvim 0.13 removes.
--
-- The fork takes filetypes under a `filetypes` key rather than as a bare list.
require("colorizer").setup({
	filetypes = {
		"css",
		"javascript",
		"typescript",
		"lua",
		"java",
		"kotlin",
		"go", -- was 'golang', which is not a Neovim filetype, so it never matched
	},
})
