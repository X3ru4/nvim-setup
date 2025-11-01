local api = require("config.highlight_api")
api.highlights = {
	DropBarMenuHoverEntry = {
		link = "Visual",
	},
	MiniCursorword = {
		bg = "#494d64",
		default = false,
	},
	MiniCursorwordCurrent = {
		link = "MiniCursorword",
	},
	DropBarMenuHoverIcon = {
		link = "Nop",
	},
	Cursor = {
		bg = "#cfcfcf",
	},
}

api.work_if("catppuccin", {
	MiniTablineCurrent = api.modify("MiniTablineCurrent", {
		italic = false,
		underline = false,
	}),
	MiniTablineModifiedCurrent = api.modify("MiniTablineModifiedCurrent", {
		italic = false,
	}),
	Visual = api.modify("Visual", {
		bold = false,
	}),
})

api.work_if("onedark", {
	Cursor = {
		bg = 15230577,
	},
	WinBar = {
		bg = "#242830",
	},
	WinBarNc = {
		link = "Normal",
	},
	MiniTablineCurrent = {
		bold = true,
		bg = 2632756,
		fg = 11252415,
	},
	MiniTablineHidden = {
		link = "WinBar",
	},
	Minicursorword = {
		bg = "#323641",
	},
	Minicursorwordcurrent = {
		link = "Minicursorword",
	},
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

api.work_if("nordic", {
	MiniIndentscopeSymbol = api.modify("MiniIndentscopeSymbol", {
		italic = false,
	}),
})

api.work_if("nordern", {
	TabLine = {
		link = "Normal",
	},
	TabLineSel = {
		link = "Normal",
	},
	MiniTablineCurrent = {
		link = "Normal",
	},
	MiniTablineModifiedCurrent = {
		link = "Normal",
	},
	MiniTablineModifiedVisible = {
		link = "Normal",
	},
	MiniTablineModifiedHidden = {
		link = "Normal",
	},
	MiniStatuslineModeNormal = {
		link = "NoiceVirtualText",
	},
	MiniStatuslineModeCommand = {
		link = "LspDiagnosticsVirtualTextWarning",
	},
})

api.apply_highlight()
