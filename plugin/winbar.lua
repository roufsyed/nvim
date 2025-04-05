-- Setup highlight groups
local winbar_bg = '#333434'
local winbar_bg_error = '#ff6c6b'
local winbar_bg_warning = '#ECBE7B'
local winbar_bg_info = '#51afef'
local winbar_bg_hint = '#98be65'

vim.api.nvim_set_hl(0, 'MyWinbarGroup', {
  fg = '#ffcc00',
  bg = winbar_bg,
  bold = false,
})

vim.api.nvim_set_hl(0, 'WinbarPath', {
  fg = '#6a9fb5',
  bg = winbar_bg,
  bold = false,
})

vim.api.nvim_set_hl(0, 'WinbarFile', {
  fg = '#f0c674',
  bg = winbar_bg,
  bold = true,
})

vim.api.nvim_set_hl(0, 'WinbarModified', {
  fg = '#cc6666',
  bg = winbar_bg,
  italic = true,
})

vim.api.nvim_set_hl(0, 'WinbarDiagnosticsError', {
  fg = winbar_bg_error,
  bg = winbar_bg,
})

vim.api.nvim_set_hl(0, 'WinbarDiagnosticsWarn', {
  fg = winbar_bg_warning,
  bg = winbar_bg,
})

vim.api.nvim_set_hl(0, 'WinbarDiagnosticsInfo', {
  fg = winbar_bg_info,
  bg = winbar_bg,
})

vim.api.nvim_set_hl(0, 'WinbarDiagnosticsHint', {
  fg = winbar_bg_hint,
  bg = winbar_bg,
})

-- Get current filename with modified flag
local function get_filename()
  local filename = vim.fn.expand('%:t')
  if filename == '' then
    return ''
  end
  local modified = vim.bo.modified and '%#WinbarModified# ' or ''
  return string.format('%%#WinbarFile# %s%s ', filename, modified)
end

-- Get relative file path
local function get_path()
  local path = vim.fn.expand('%:~:.:h')
  return path ~= '.' and string.format('%%#WinbarPath# %s/', path) or ''
end

-- Get diagnostic summary from LSP
local function get_diagnostics()
  local diagnostics = vim.diagnostic.get(0)
  local counts = { Error = 0, Warn = 0, Info = 0, Hint = 0 }

  for _, d in ipairs(diagnostics) do
    if d.severity == vim.diagnostic.severity.ERROR then
      counts.Error = counts.Error + 1
    elseif d.severity == vim.diagnostic.severity.WARN then
      counts.Warn = counts.Warn + 1
    elseif d.severity == vim.diagnostic.severity.INFO then
      counts.Info = counts.Info + 1
    elseif d.severity == vim.diagnostic.severity.HINT then
      counts.Hint = counts.Hint + 1
    end
  end

  local result = ''
  if counts.Error > 0 then
    result = result .. string.format('%%#WinbarDiagnosticsError# E:%d ', counts.Error)
  end
  if counts.Warn > 0 then
    result = result .. string.format('%%#WinbarDiagnosticsWarn# W:%d ', counts.Warn)
  end
  if counts.Info > 0 then
    result = result .. string.format('%%#WinbarDiagnosticsInfo# I:%d ', counts.Info)
  end
  if counts.Hint > 0 then
    result = result .. string.format('%%#WinbarDiagnosticsHint# H:%d ', counts.Hint)
  end

  return result
end

-- Set winbar content
local function set_winbar()
  local content = table.concat({
    get_path(),
    get_filename(),
    get_diagnostics(),
  })
  vim.wo.winbar = '%#MyWinbarGroup#' .. content
end

-- Attach autocommands
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufFilePost', 'BufWritePost', 'DiagnosticChanged' }, {
  callback = set_winbar,
})

