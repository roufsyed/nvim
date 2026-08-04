vim.o.sessionoptions = vim.o.sessionoptions .. ",localoptions"
local auto_session = require("auto-session")

auto_session.setup({
	auto_restore = false,
	auto_save = true,
	enabled = true,
	log_level = "error",
	root_dir = "/Users/rouf/.config/nvim/sessions/"
})

-- Only restore if nvim started with no file args
if vim.fn.argc() == 0 then
	vim.schedule(function()
		auto_session.auto_restore_session()
	end)
end

-- Optional keymaps
vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>s", ":SessionSearch<CR>", { desc = "Restore session" })
