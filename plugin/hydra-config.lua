local Hydra = require("hydra")

Hydra({
	name = "Resize Window",
	mode = { "n" },
	body = "z",
	config = {
		-- color = "pink",
	},
	heads = {
		-- resizing window
		{ "h", "<C-w>3<" },
		{ "l", "<C-w>3>" },
		{ "j", "<C-w>2+" },
		{ "k", "<C-w>2-" },

    -- equalize window sizes
    { "e", "<C-w>=" },

		-- window movement
		{ "H", "<Cmd>WinShift left<CR>" },
		{ "L", "<Cmd>WinShift right<CR>" },
		{ "J", "<Cmd>WinShift down<CR>" },
		{ "K", "<Cmd>WinShift up<CR>" },

    -- Tab rename and clear name
		{ "tr", ":lua require('tabline.actions').set_tabname()<CR>" },
		{ "tc", ":lua require('tabline.actions').clear_tabname()<CR>" },

    -- buffer navigation
    {"[", ":bn<CR>"},
    {"]", ":bp<CR>"},

    -- Tab navigations
    {"}", ":tabnext<CR>"},
    {"{", ":tabprevious<CR>"},

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
		{ "<return>", nil, { exit = true, nowait = true } },
	},
})
