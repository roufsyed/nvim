-- winbar.lua

-- Define colors
local colors = {
	bg       = '#333434',
	error    = '#ff6c6b',
	warn     = '#ECBE7B',
	info     = '#51afef',
	hint     = '#98be65',
	file     = '#f0c674',
	path     = '#6a9fb5',
	modified = '#cc6666',
	group_fg = '#ffcc00',
}

-- Setup highlight groups
local function define_highlight(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

define_highlight('MyWinbarGroup', { fg = colors.group_fg, bg = colors.bg, bold = false })
define_highlight('WinbarPath', { fg = colors.path, bg = colors.bg, bold = false })
define_highlight('WinbarFile', { fg = colors.file, bg = colors.bg, bold = true })
define_highlight('WinbarModified', { fg = colors.modified, bg = colors.bg, italic = true })
define_highlight('WinbarDiagnosticsError', { fg = colors.error, bg = colors.bg })
define_highlight('WinbarDiagnosticsWarn', { fg = colors.warn, bg = colors.bg })
define_highlight('WinbarDiagnosticsInfo', { fg = colors.info, bg = colors.bg })
define_highlight('WinbarDiagnosticsHint', { fg = colors.hint, bg = colors.bg })

-- Utility to sanitize control characters from winbar
local function sanitize(text)
	return text:gsub("[%c]", "")
end

-- Get current filename with modified flag
local function get_filename()
	local filename = vim.fn.expand('%:t')
	if filename == '' then return '' end
	local modified = vim.bo.modified and '%#WinbarModified# ' or ''
	return string.format('%%#WinbarFile# %s%s ', filename, modified)
end

-- Get relative file path
local function get_path()
	local path = vim.fn.expand('%:~:.:h')
	return (path ~= '.' and path ~= '') and string.format('%%#WinbarPath# %s/', path) or ''
end

-- Get diagnostic summary
local function get_diagnostics()
	local diagnostics = vim.diagnostic.get(0)
	local count = { Error = 0, Warn = 0, Info = 0, Hint = 0 }

	for _, d in ipairs(diagnostics) do
		if d.severity == vim.diagnostic.severity.ERROR then
			count.Error = count.Error + 1
		elseif d.severity == vim.diagnostic.severity.WARN then
			count.Warn = count.Warn + 1
		elseif d.severity == vim.diagnostic.severity.INFO then
			count.Info = count.Info + 1
		elseif d.severity == vim.diagnostic.severity.HINT then
			count.Hint = count.Hint + 1
		end
	end

	local result = ''
	if count.Error > 0 then
		result = result .. string.format('%%#WinbarDiagnosticsError# E:%d ', count.Error)
	end
	if count.Warn > 0 then
		result = result .. string.format('%%#WinbarDiagnosticsWarn# W:%d ', count.Warn)
	end
	if count.Info > 0 then
		result = result .. string.format('%%#WinbarDiagnosticsInfo# I:%d ', count.Info)
	end
	if count.Hint > 0 then
		result = result .. string.format('%%#WinbarDiagnosticsHint# H:%d ', count.Hint)
	end

	return result
end

-- Set winbar content
local function set_winbar()
	local content = table.concat({
		-- get_path(), -- Disabled file path as it was getting to long for the vertical split and in somecases hiding the file name
		get_filename(),
		get_diagnostics(),
	})
	vim.wo.winbar = sanitize('%#MyWinbarGroup#' .. content)
end

-- Autocommands
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufFilePost', 'BufWritePost', 'DiagnosticChanged' }, {
	callback = set_winbar,
})
