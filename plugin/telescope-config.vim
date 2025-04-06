lua << EOF
require('telescope').setup{
  defaults = {
	sorting_strategy = "ascending",
    layout_strategy = "horizontal",  -- Alternative: "bottom_pane"
    layout_config = {
      height = 0.5,  -- 40% of screen height
      width = 0.8,   -- 50% of screen width
	  horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
    },
  },
  pickers = {
    find_files = { previewer = false },  -- Explicitly disable preview
    buffers = { previewer = false },    -- Explicitly disable preview
  }
}
EOF
