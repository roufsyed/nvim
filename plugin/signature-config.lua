require'lsp_signature'.setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  },
  floating_window = true,
  hint_enable = false,  -- disables virtual text hints
  doc_lines = 1,        -- minimal docs line
})

