-- ~/.config/nvim/lua/colors/slate.lua
local M = {}

-- Palette (hex)
local palette = {
	bg      = "#0b0f12", -- near-black
	bg_alt  = "#0f1316", -- slightly lighter
	slate1  = "#1a2025", -- slate dark
	slate2  = "#2a3238", -- slate medium
	slate3  = "#445058", -- slate light
	white   = "#e6eef3",
	grey    = "#9aa6af",
	accent  = "#9fb0ff", -- soft blue for keywords/links
	success = "#7fdba5",
	warn    = "#ffcf6b",
	error   = "#ff8b8b",
	comment = "#6f7a80",
}

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.setup()
	-- clear & background
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
	vim.o.background = "dark"
	vim.g.colors_name = "slate"

	-- basics
	hi("Normal", { fg = palette.white, bg = palette.bg })
	hi("NormalNC", { fg = palette.grey, bg = palette.bg })
	hi("CursorLine", { bg = palette.slate1 })
	hi("Visual", { bg = palette.slate2 })
	hi("LineNr", { fg = palette.slate3, bg = palette.bg })
	hi("CursorLineNr", { fg = palette.white, bg = palette.slate1, bold = true })
	hi("StatusLine", { fg = palette.white, bg = palette.slate1 })
	hi("StatusLineNC", { fg = palette.grey, bg = palette.bg_alt })
	hi("Pmenu", { fg = palette.white, bg = palette.slate2 })
	hi("PmenuSel", { fg = palette.bg, bg = palette.accent })
	hi("FloatBorder", { fg = palette.slate3, bg = palette.bg })
	hi("NormalFloat", { fg = palette.white, bg = palette.bg_alt })

	-- syntax
	hi("Comment", { fg = palette.comment, italic = true })
	hi("Constant", { fg = palette.accent })
	hi("String", { fg = palette.success })
	hi("Character", { fg = palette.success })
	hi("Number", { fg = palette.accent })
	hi("Boolean", { fg = palette.accent })
	hi("Identifier", { fg = palette.white })
	hi("Function", { fg = palette.accent, bold = true })
	hi("Statement", { fg = palette.accent })
	hi("Conditional", { fg = palette.warn })
	hi("Repeat", { fg = palette.warn })
	hi("Label", { fg = palette.accent })
	hi("Operator", { fg = palette.white })
	hi("Keyword", { fg = palette.accent, bold = true })
	hi("Exception", { fg = palette.error })

	-- UI
	hi("Search", { fg = palette.bg, bg = palette.accent })
	hi("IncSearch", { fg = palette.bg, bg = palette.warn })
	hi("Substitute", { fg = palette.bg, bg = palette.warn })
	hi("MatchParen", { fg = palette.bg, bg = palette.slate3 })
	hi("DiffAdd", { fg = palette.success, bg = palette.bg })
	hi("DiffChange", { fg = palette.accent, bg = palette.bg })
	hi("DiffDelete", { fg = palette.error, bg = palette.bg })
	hi("DiffText", { fg = palette.white, bg = palette.slate2 })

	-- Treesitter (common)
	hi("@comment", { fg = palette.comment, italic = true })
	hi("@constant", { fg = palette.accent })
	hi("@string", { fg = palette.success })
	hi("@function", { fg = palette.accent, bold = true })
	hi("@keyword", { fg = palette.accent, bold = true })
	hi("@variable", { fg = palette.white })
	hi("@type", { fg = palette.slate3 })
	hi("@parameter", { fg = palette.grey })

	-- LSP
	hi("DiagnosticError", { fg = palette.error })
	hi("DiagnosticWarn", { fg = palette.warn })
	hi("DiagnosticInfo", { fg = palette.accent })
	hi("DiagnosticHint", { fg = palette.grey })
	hi("DiagnosticUnderlineError", { undercurl = true, sp = palette.error })
	hi("DiagnosticUnderlineWarn", { undercurl = true, sp = palette.warn })

	-- Misc plugins (light)
	hi("TelescopeBorder", { fg = palette.slate3, bg = palette.bg })
	hi("TelescopePromptBorder", { fg = palette.slate2, bg = palette.bg_alt })
	hi("TelescopeNormal", { fg = palette.white, bg = palette.bg })
	hi("VertSplit", { fg = palette.slate2, bg = palette.bg })
	hi("IblIndent", { fg = palette.slate2 })
	hi("IblWhitespace", { fg = palette.slate1 })
	hi("IblScope", { fg = palette.accent })
	vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a3238" })  -- slate2
	vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#1a2025" }) -- slate1
	vim.api.nvim_set_hl(0, "IblScope", { fg = "#9fb0ff" })   -- accent



	-- Terminal colors
	vim.g.terminal_color_0  = palette.bg
	vim.g.terminal_color_1  = palette.error
	vim.g.terminal_color_2  = palette.success
	vim.g.terminal_color_3  = palette.warn
	vim.g.terminal_color_4  = palette.accent
	vim.g.terminal_color_5  = palette.slate3
	vim.g.terminal_color_6  = palette.slate2
	vim.g.terminal_color_7  = palette.white
	vim.g.terminal_color_8  = palette.slate1
	vim.g.terminal_color_9  = palette.error
	vim.g.terminal_color_10 = palette.success
	vim.g.terminal_color_11 = palette.warn
	vim.g.terminal_color_12 = palette.accent
	vim.g.terminal_color_13 = palette.slate3
	vim.g.terminal_color_14 = palette.slate2
	vim.g.terminal_color_15 = palette.white
end

-- Auto-run setup on require("colors.slate")
M.setup = M.setup
return M
