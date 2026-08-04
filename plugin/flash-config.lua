require('flash').setup({
	labels = "asdfghjklqwertyuiopzxcvbnm", -- label keys
	highlight = {
		backdrop = false,               -- disable backdrop highlight
		matches = false,                -- disable match animations
	},
	jump = {
		autojump = true, -- jump instantly without animation
	},
	modes = {
		char = {
			enabled = true, -- enable char mode for single-letter jumps
			multi_line = true,
			highlight = {
				backdrop = false,
			},
		},
		search = {
			enabled = false, -- enable search mode
			highlight = {
				backdrop = false,
			},
		},
	},
})

-- Remap ',' to flash.jump()
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>,', function()
	require('flash').jump()
end, { desc = "Flash Jump" })
