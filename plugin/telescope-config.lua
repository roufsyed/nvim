local telescope = require("telescope")

telescope.setup({
	defaults = {
		-- Used by live_grep / grep_string. --hidden picks up dotfiles; .git is
		-- excluded explicitly since --hidden would otherwise walk into it.
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob=!**/.git/*",
		},
		-- Build output and vendored deps: keeping these out of the candidate set
		-- is the other half of making search fast on a big repo.
		file_ignore_patterns = {
			"%.git/",
			"node_modules/",
			"target/",   -- rust
			"vendor/",   -- go
			"build/",
			"dist/",
			"%.gradle/", -- java/kotlin
			"%.idea/",
			"%.class$",
			"%.o$",
			"%.so$",
			"%.a$",
			"%.jar$",
			"%.png$",
			"%.jpg$",
			"%.jpeg$",
			"%.pdf$",
		},
		path_display = { "truncate" },
	},

	pickers = {
		find_files = {
			find_command = {
				"fd", "--type", "f", "--hidden", "--strip-cwd-prefix", "--exclude", ".git",
			},
		},
		buffers = {
			sort_lastused = true,
			sort_mru = true,
		},
	},

	extensions = {
		-- Loading the extension is NOT enough on its own -- without these
		-- overrides telescope keeps using its pure-Lua sorters. The overrides are
		-- what actually swaps in the C implementation.
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

-- build/libfzf.so is already compiled; this just wires it in.
telescope.load_extension("fzf")

-- NOTE: deliberately NOT loading the "projects" extension here. project.nvim was
-- removed from the plugin list, and the old load_extension('projects') call is
-- what would error on startup.
