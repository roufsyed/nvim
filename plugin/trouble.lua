require("trouble").setup({
  position = "bottom",     -- Options: "bottom", "top", "left", "right"
  height = 30,             -- Height for horizontal splits
  width = 100,              -- Width for vertical splits
  icons = {
    error = "E:",
    warning = "W:",
    hint = "H:",
    information = "I:",
    other = "Other:",
  },
  fold_open = "",
  fold_closed = "",
  group = true,
  padding = true,
  use_diagnostic_signs = true,
  action_keys = {
    close = "q",
    cancel = "<esc>",
    refresh = "r",
    jump = { "<cr>", "<tab>" }, -- Jump only when pressing <CR> or <Tab>
    open_split = "<c-h>",
    open_vsplit = "<c-v>",
    open_tab = "<c-t>",
    toggle_mode = "m",
    toggle_preview = "P",
    hover = "K",
    preview = "p",
    close_folds = {"zM", "zm"},
    open_folds = {"zR", "zr"},
    toggle_fold = {"zA", "za"},
    previous = "k",
    next = "j"
  },
  auto_open = false,   -- Do not open Trouble automatically
  auto_close = false,  -- Do not close Trouble automatically
  auto_preview = false -- Do not automatically preview location
})

