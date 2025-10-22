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
    link = "MiniCursorword"
  },
	DropBarMenuHoverIcon = {
		link = "Nop",
	},
}

api.modify("MiniIndentscopeSymbol", {
	bold = true,
})

api.work_if("catppuccin-macchiato", {
  MiniTablineCurrent = api.modify("MiniTablineCurrent", {
    italic = false,
    underline = false,
  }),
  MiniTablineModifiedCurrent = api.modify("MiniTablineModifiedCurrent", {
    italic = false,
  })
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

api.apply_highlight()
