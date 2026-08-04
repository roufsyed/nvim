local Hydra = require("hydra")

Hydra({
	name = "resize window",
	mode = { "n" },
	body = "z",
	config = {
		-- color = "pink",
	},
	heads = {
		-- resizing window
		{ "h",        "<C-w>3<" },
		{ "l",        "<C-w>3>" },
		{ "j",        "<C-w>2+" },
		{ "k",        "<C-w>2-" },

		-- equalize window sizes
		{ "e",        "<C-w>=" },

		-- exit hydra mode
		{ "q",        nil,      { exit = true, nowait = true } },
		{ "<Esc>",    nil,      { exit = true, nowait = true } },
		{ "<return>", nil,      { exit = true, nowait = true } },

		-- convert all horizontal splits to vertical
		{ "v", function()
			local win_count = vim.fn.winnr('$')
			for i = 1, win_count do
				vim.cmd(i .. "wincmd H")
			end
		end, { desc = "horizontal → vertical" } },

		-- convert all vertical splits to horizontal
		{ "s", function()
			local win_count = vim.fn.winnr('$')
			for i = 1, win_count do
				vim.cmd(i .. "wincmd K")
			end
		end, { desc = "vertical → horizontal" } },
	},
})
