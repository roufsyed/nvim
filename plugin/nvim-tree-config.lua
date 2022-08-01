require("nvim-tree").setup({
  open_on_setup = true,
  sync_root_with_cwd = true, -- use cd instead of lcd
  sort_by = "case_sensitive",
  view = {
    side = "right",
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  renderer = {
    group_empty = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = true, -- cwd = change working directory
  },
  actions = {
    change_dir = {
      enable = true,
      global = false, -- change this setting to change working dir globally
      restrict_above_cwd = false,
    },
  },
})
