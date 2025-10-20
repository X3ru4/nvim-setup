local api = require("config.highlight_module")

api.highlights = {
	DropBarMenuHoverEntry = {
		link = "Visual",
	},
	DropBarMenuHoverIcon = {
		link = "Nop",
	},
}

api.modify("MiniIndentscopeSymbol", {
	bold = true,
})

api.work_if("onedark", {
	WinBar = {
		bg = "#242830",
	},
	WinBarNc = {
		link = "Normal",
	},
	MiniTablineCurrent = {
		link = "TabLine",
	},
	MiniTablineHidden = {
		link = "TabLineFill",
	},
	MiniTablineVisible = {
		link = "TabLine",
	},
	-- Minicursorword = {
	-- 	bg = "#323641",
	-- },
	-- Minicursorwordcurrent = {
	-- 	link = "Minicursorword",
	-- },
	IncSearch = {
		bg = "#424951",
		bold = true,
	},
	DropBarMenuCurrentContext = {
		link = "Visual",
	},
})

api.work_if("nord", {
	WinBar = {
		link = "StatusLine",
	},
	WinBarNc = {
		link = "StatusLineNC",
	},
})

api.apply_highlight()
