-------------------------------------------------
-- Mostly default
-------------------------------------------------
-- require('lualine').setup {
-- 	options = {
-- 		theme = 'auto', -- auto, base16, jellybeans, tokyonight
-- 		section_separators = { left = '', right = '' },
-- 		component_separators = { left = '', right = '' },
-- 		always_divide_middle = false,
-- 		globalstatus = true,
-- 	},
-- 	extensions = {'quickfix', 'toggleterm','fugitive','nvim-tree'},
-- }

-- -------------------------------------------------
-- Personalised config
-- -------------------------------------------------
local lualine = require('lualine')

-- Color table for highlights
local colors = {
  -- bg       = '#181A18',
  -- bg       = '#272727',
  bg       = '#16161e',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B', 
	cyan     = '#008080', 
	darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}


local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
	
	--
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
		always_divide_middle = false,
		globalstatus = true,
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg },
				y = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
		lualine_c = {},
		lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
	'mode',
  color = { 
		bg = colors.bg,
		fg = colors.fg,
		gui = '' 
	},
}

ins_left {
  'branch',
  icon = '',
  color = { 
		bg = colors.bg,
		fg = colors.fg,
		gui = '' 
	},
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.fg, gui = '' },
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_left {
  'diagnostics',
  sources = { 'coc' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

-- Tabs in status line
-- ins_left {
-- 	'tabs',
-- 	colored=true,
-- 	max_length = vim.o.columns / 1,
-- 	mode = 2, -- 0: Shows tab_nr
-- 						-- 1: Shows tab_name
-- 						-- 2: Shows tab_nr + tab_name
-- 	tabs_color = {
-- 		-- Same values as the general color option can be used here.
-- 		active = {fg = colors.magenta},
-- 		inactive = {},
-- 	},
-- }

ins_right { 'location' }

ins_right { 'progress', color = { fg = colors.fg, gui = '' } }

ins_right {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = '' },
  -- color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
