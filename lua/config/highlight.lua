local M = {}

M.setup = function()
	local hl_api = require("util.hl_api")
	hl_api.highlights = {
		Yank = {
			fg = "White",
			bg = "gray",
		},
		StatusLine = {
			link = "Normal",
		},
		WinBar = {
			link = "Normal",
		},
		MiniTablineCurrent = {
			link = "Normal",
		},
		MiniTablineModifiedCurrent = {
			link = "Normal",
		},
		MiniTablineHidden = {
			link = "StatusLineNC",
		},
		MiniTablineModifiedHidden = {
			link = "MiniTablineHidden",
		},
		MiniTablineFill = {
			link = "Normal",
		},
		DropBarMenuHoverEntry = {
			link = "Visual",
		},
		MiniCursorword = {
			bg = "#494d64",
			default = false,
		},
		DropBarMenuHoverIcon = vim.empty_dict(),
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
		hl_api.modify("DropBarIconUISeparator", {
			italic = false,
		}),
		hl_api.modify("DropBarIconUISeparatorNC", {
			italic = false,
		}),
		hl_api.modify("DropBarIconUISeparatorMenu", {
			italic = false,
		}),
	}

	hl_api.work_if({
		"catppuccin-frappe",
		"catppuccin-mocha",
		"catppuccin-macchiato",
		"catppuccin-latte",
	}, {
		hl_api.modify("MiniCursorwordCurrent", {
			link = "MiniCursorword",
		}),
		hl_api.modify("MiniTablineCurrent", {
			italic = false,
			underline = false,
		}),
		hl_api.modify("MiniTablineModifiedCurrent", {
			italic = false,
			underline = false,
		}),
		hl_api.modify("Visual", {
			bold = true,
		}),
		hl_api.modify("IncSearch", {
			bold = true,
		}),
	})

	hl_api.work_if("onedark", {
		WinBar = {
			bg = "#242830",
		},
		WinBarNc = {
			link = "Normal",
		},
		IncSearch = {
			bg = "#424951",
			bold = true,
		},
		DropBarMenuCurrentContext = {
			link = "Visual",
		},
	})

	hl_api.work_if({
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
		hl_api.modify("DropBarIconUISeparator", {
			italic = false,
		}),
		hl_api.modify("DropBarIconUISeparatorNC", {
			italic = false,
		}),
		hl_api.modify("DropBarIconUISeparatorMenu", {
			italic = false,
		}),
	})

	hl_api.work_if("gruvbox", {
		SignColumn = {
			link = "Normal",
		},
		CursorLineSign = {
			link = "CursorLine",
		},
	})

	hl_api.apply()
end

return M
