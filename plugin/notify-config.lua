require("notify").setup({
	background_colour = "NotifyBackground", -- highlight group for background color
	fps = 30,                            -- animation frame rate
	icons = {                            -- icons for different levels
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = ""
	},
	level = 2,                   -- minimum log level to show (2 = WARN)
	minimum_width = 50,          -- minimum width of notification window
	render = "default",          -- render style ("default", "minimal", etc.)
	stages = "fade_in_slide_out", -- animation style
	time_formats = {             -- timestamp formats
		notification = "%T",     -- HH:MM:SS for live notifications
		notification_history = "%FT%T" -- ISO format for history
	},
	timeout = 3700,              -- notification duration in ms
	top_down = true              -- show new notifications at the top
})
