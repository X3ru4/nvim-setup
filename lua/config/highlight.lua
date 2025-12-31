local M = {}
local api = require("config.highlight_api")

M.setup = function()
	api.highlights = {
		StatusLine = {
			link = "Normal",
		},
		DropBarMenuHoverEntry = {
			link = "Visual",
		},
		MiniCursorword = {
			bg = "#494d64",
			default = false,
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

	api.work_if({
		"tokyonight",
		"tokyonight-day",
		"tokyonight-moon",
		"tokyonight-night",
		"tokyonight-storm",
	}, {
		nil and nil, -- =))
	})

	api.work_if({
		"catppuccin-frappe",
		"catppuccin-mocha",
		"catppuccin-macchiato",
		"catppuccin-latte",
	}, {
		callback = function()
			api.modify("MiniTablineCurrent", {
				italic = false,
				underline = true,
			})
			api.modify("MiniTablineModifiedCurrent", {
				italic = false,
				underline = true,
			})
			api.modify("Visual", {
				bold = true,
			})
		end,
	})

	api.work_if("onedark", {
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

	api.work_if({
		"kanagawa",
		"kanagawa-paper-ink",
		"kanagawa-paper-canvas",
	}, {
		MiniTablineModifiedCurrent = {
			link = "MiniTablineCurrent",
		},
		MiniTablineModifiedHidden = {
			link = "MiniTablineCurrentHidden",
		},
		MiniTablineModifiedVisible = {
			link = "MiniTablineCurrentVisible",
		},
		MiniCursorwordCurrent = vim.empty_dict(),
		callback = function()
			api.modify("DropBarIconUISeparator", {
				italic = false,
			})
			api.modify("DropBarIconUISeparatorNC", {
				italic = false,
			})
			api.modify("DropBarIconUISeparatorMenu", {
				italic = false,
			})
		end,
	})

	api.work_if("gruvbox", {
		SignColumn = {
			link = "Normal",
		},
		CursorLineSign = {
			link = "CursorLine",
		},
	})

	api.apply_highlight()
end

return M
