local api = require("config.highlight_module")

api.highlights = {
	DropBarMenuHoverEntry = {
		link = "Visual",
	},
	DropBarMenuHoverIcon = {},
	MiniCursorword = {
		underline = true,
	},
	MiniCursorwordCurrent = {
		link = "MiniCursorword",
	},
	MiniIndentscopeSymbol = {
		fg = api.get("DiagnosticVirtualTextHint").fg,
		bold = true,
	},
}

api.workIf("onedark", {
	WinBar = {
		link = "Pmenu",
	},
	WinBarNc = {
		link = "Pmenu",
	},
	MiniTablineCurrent = {
		fg = api.get("PmenuSel").bg,
    bold = true
	},
})

api.workIf("nord", {
	WinBar = {
		link = "StatusLine",
	},
	WinBarNc = {
		link = "StatusLineNC",
	},
})

api.aplly_highlight()
