local M = {}

M.setup = function()
	local hl = require("utility.highlight")

	hl.highlights = {
		-- Custom
		ModeOther = {
			link = "MiniStatuslineModeOther",
		},
		ModeNormal = {
			link = "MiniStatuslineModeNormal",
		},
		ModeInsert = {
			link = "MiniStatuslineModeInsert",
		},
		ModeVisual = {
			link = "MiniStatuslineModeVisual",
		},
		ModeReplace = {
			link = "MiniStatuslineModeReplace",
		},
		ModeCommand = {
			link = "MiniStatuslineModeCommand",
		},
		Yank = {
			bg = hl.get("Visual").bg,
		},

		-- Plugins
    -- multicutsor.nvim
		MultiCursorCursor = { reverse = true },
		MultiCursorVisual = { link = "Visual" },
		MultiCursorSign = { link = "SignColumn" },
		MultiCursorMatchPreview = { link = "Search" },
		MultiCursorDisabledCursor = { reverse = true },
		MultiCursorDisabledVisual = { link = "Visual" },
		MultiCursorDisabledSign = { link = "SignColumn" },

		-- Vanilla
		-- StatusLine = {
		-- 	link = "Normal",
		-- },
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
			link = "StatusLineNC",
		},
		DropBarMenuHoverEntry = {
			link = "Visual",
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
		hl.modify("DropBarIconUISeparator", {
			italic = false,
		}),
		hl.modify("DropBarIconUISeparatorNC", {
			italic = false,
		}),
		hl.modify("DropBarIconUISeparatorMenu", {
			italic = false,
		}),
	}

	hl.set_match("gruvbox-material", {
		DropBarMenuHoverEntry = {
			link = "PmenuThumb",
		},
		LazyProp = {
			link = "Operator",
		},

		-- BlinkPair
		BlinkPairsUnmatched = {
			fg = hl.get("Red").fg,
			reverse = true,
			bold = true,
		},
		BlinkPairsBlue = {
			link = "Blue",
		},
		BlinkPairsOrange = {
			link = "Orange",
		},
		BlinkPairsPurple = {
			link = "Purple",
		},

		-- BlinkIndent
		BlinkIndentRed = {
			link = "Red",
		},
		BlinkIndentCyan = {
			link = "Aqua",
		},
		BlinkIndentBlue = {
			link = "Blue",
		},
		BlinkIndentGreen = {
			link = "Green",
		},
		BlinkIndentYellow = {
			link = "Yellow",
		},
		BlinkIndentViolet = {
			link = "Purple",
		},
		BlinkIndentOrange = {
			link = "Orange",
		},
	})

	hl.set_match("everforest", {
		LazyProp = {
			link = "Operator",
		},

		-- BlinkPair
		BlinkPairsUnmatched = {
			fg = hl.get("Red").fg,
			reverse = true,
			bold = true,
		},
		BlinkPairsBlue = {
			link = "Blue",
		},
		BlinkPairsOrange = {
			link = "Orange",
		},
		BlinkPairsPurple = {
			link = "Purple",
		},

		-- BlinkIndent
		BlinkIndentRed = {
			link = "Red",
		},
		BlinkIndentCyan = {
			link = "Aqua",
		},
		BlinkIndentBlue = {
			link = "Blue",
		},
		BlinkIndentGreen = {
			link = "Green",
		},
		BlinkIndentYellow = {
			link = "Yellow",
		},
		BlinkIndentViolet = {
			link = "Purple",
		},
		BlinkIndentOrange = {
			link = "Orange",
		},
	})

	hl.set_match("edge", function()
		local config = vim.fn["edge#get_configuration"]()
		local palette = vim.fn["edge#get_palette"](config.style, config.dim_foreground, config.colors_override)
		local set_hl = vim.fn["edge#highlight"]

		return {
			LazyProp = {
				link = "Keyword",
			},

			-- BlinkPair
			BlinkPairsUnmatched = {
				fg = hl.get("red").fg,
				reverse = true,
				bold = true,
			},
			BlinkPairsBlue = {
				link = "Blue",
			},
			BlinkPairsOrange = {
				link = "Purple",
			},
			BlinkPairsPurple = {
				link = "Purple",
			},

			-- BlinkIndent
			BlinkIndentRed = {
				link = "Red",
			},
			BlinkIndentCyan = {
				link = "Cyan",
			},
			BlinkIndentBlue = {
				link = "Blue",
			},
			BlinkIndentGreen = {
				link = "Green",
			},
			BlinkIndentYellow = {
				link = "Yellow",
			},
			BlinkIndentViolet = {
				link = "Purple",
			},
			BlinkIndentOrange = {
				link = "Purple",
			},
		}
	end)

  -- Using ! at the end of the string to match more variants
	hl.set_match("catppuccin!", function()
		hl.modify("MiniCursorwordCurrent", {
			link = "MiniCursorword",
		})
		hl.modify("MiniTablineCurrent", {
			italic = false,
			underline = false,
		})
		hl.modify("MiniTablineModifiedCurrent", {
			italic = false,
			underline = false,
		})
		hl.modify("Visual", {
			bold = true,
		})
		hl.modify("IncSearch", {
			bold = true,
		})

		return {}
	end)

	hl.set_match("onedark", {
		WinBar = {
			link = "Normal",
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

	hl.set_match("kanagawa!", {
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
		hl.modify("DropBarIconUISeparator", {
			italic = false,
		}),
		hl.modify("DropBarIconUISeparatorNC", {
			italic = false,
		}),
		hl.modify("DropBarIconUISeparatorMenu", {
			italic = false,
		}),
	})

	hl.set_match("gruvbox", {
		SignColumn = {
			link = "Normal",
		},
		CursorLineSign = {
			link = "CursorLine",
		},
	})

	hl.set_match("vscode", function()
		local colors = require("vscode.colors").get_colors()

		local fg = colors.vscBack
		return {
			ModeOther = {
				bg = colors.vscRed,
				fg = fg,
				bold = true,
			},
			ModeNormal = {
				bg = colors.vscBlue,
				fg = fg,
				bold = true,
			},
			ModeInsert = {
				bg = colors.vscGreen,
				fg = fg,
				bold = true,
			},
			ModeVisual = {
				bg = colors.vscPink,
				fg = fg,
				bold = true,
			},
			ModeReplace = {
				bg = colors.vscLightRed,
				fg = fg,
				bold = true,
			},
			ModeCommand = {
				bg = colors.vscOrange,
				fg = fg,
				bold = true,
			},

			-- Mini.Diff
			MiniDiffSignAdd = {
				fg = colors.vscGreen,
			},
			MiniDiffSignDelete = {
				fg = colors.vscRed,
			},
			MiniDiffSignChange = {
				fg = colors.vscYellowOrange,
			},

			-- BlinkPair
			BlinkPairsUnmatched = {
				fg = colors.vscRed,
				reverse = true,
				bold = true,
			},
			BlinkPairsBlue = {
				link = "RainbowDelimiterBlue",
			},
			BlinkPairsOrange = {
				link = "RainbowDelimiterOrange",
			},
			BlinkPairsPurple = {
				link = "RainbowDelimiterPurple",
			},

			-- BlinkIndent
			BlinkIndentRed = {
				link = "RainbowDelimiterRed",
			},
			BlinkIndentCyan = {
				link = "RainbowDelimiterCyan",
			},
			BlinkIndentBlue = {
				link = "RainbowDelimiterBlue",
			},
			BlinkIndentGreen = {
				link = "RainbowDelimiterGreen",
			},
			BlinkIndentYellow = {
				link = "RainbowDelimiterYellow",
			},
			BlinkIndentViolet = {
				link = "RainbowDelimiterViolet",
			},
			BlinkIndentOrange = {
				link = "RainbowDelimiterOrange",
			},
		}
	end)

	hl.apply()
end

return M
