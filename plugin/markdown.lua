require('render-markdown').setup({
	max_file_size = 100,		
	heading = {
		enabled = false,
		sign = fasle,
		position = 'inline',
		icons = {''},
		signs = {''},
	},
	code = {
		enable = true,
		sign = false,
		style = 'normal',
		width = 'block',
		left_pad = 1,
		right_pad = 1,
		min_width = 100,
	},
	checkbox = {
		enabled = true,
		unchecked = {
			icon = '[✕]',
			highlight = 'RenderMarkdownUnchecked',
		},
		checked = {
			icon = '[✓]',
			highlight = 'RenderMarkdownChecked',
		},
	},
	quote = {
			enabled = true,
			icon = '▋',
			repeat_linebreak = true,
			highlight = 'RenderMarkdownQuote',
	},
	pipe_table = {
			enabled = true,
			style = 'full',
			cell = 'raw',
			alignment_indicator = '━',
			border = {
					'┌', '┬', '┐',
					'├', '┼', '┤',
					'└', '┴', '┘',
					'│', '─',
			},
			head = 'RenderMarkdownTableHead',
			row = 'RenderMarkdownTableRow',
			filler = 'RenderMarkdownTableFill',
    },
		link = {
			enabled = true,
			image = ' ',
			hyperlink = ' ',
			highlight = 'RenderMarkdownLink',
		},
})
