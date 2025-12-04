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
	SpellBad = {
		strikethrough = true,
	},
	SpellCap = {
		strikethrough = true,
	},
	SpellRare = {
		strikethrough = true,
	},
	SpellLocal = {
		strikethrough = true,
	},
}

api.work_if("catppuccin", {
	api.modify("MiniTablineCurrent", {
		italic = false,
		underline = true,
	}),
	api.modify("MiniTablineModifiedCurrent", {
		italic = false,
		underline = true,
	}),
	api.modify("Visual", {
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
	api.modify("MiniIndentscopeSymbol", {
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

api.work_if("kanagawa", {
	MiniTablineModifiedCurrent = {
		link = "MiniTablineCurrent",
	},
	MiniTablineModifiedHidden = {
		link = "MiniTablineCurrentHidden",
	},
	MiniTablineModifiedVisible = {
		link = "MiniTablineCurrentVisible",
	},
})

api.apply_highlight()
