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

		-- Blink.cmp
		BlinkCmpMenu = {
			link = "Normal",
		},

		fn = function()
			-- Syntax
			hl.modify("@keyword.return", {
				italic = true,
			})
			hl.modify("@keyword.exception", {
				italic = true,
			})
			hl.modify("@keyword.conditional", {
				italic = true,
			})
			hl.modify("@keyword.repeat", {
				italic = true,
			})
			hl.modify("@string", {
				italic = true,
			})
			hl.modify("TSKeyword", {
				italic = true,
			})

			-- Blink.cmp
			if vim.g.blinkcmp_border == "rounded" then
				hl.set("BlinkCmpMenu", {
					link = "Normal",
				})
				hl.set("BlinkCmpMenuBorder", {
					link = "FloatBorder",
				})
			end
		end,
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

		fn = function()
			-- Syntax
			hl.modify("@keyword.return", {
				italic = true,
			})
			hl.modify("@keyword.exception", {
				italic = true,
			})
			hl.modify("@keyword.repeat", {
				italic = true,
			})

			-- Blink.cmp
			if vim.g.blinkcmp_border == "rounded" then
				hl.set("BlinkCmpMenu", {
					link = "Normal",
				})
				hl.set("BlinkCmpMenuBorder", {
					link = "FloatBorder",
				})
			end
		end,
	})

	hl.set_match("edge", function()
		-- Syntax
		hl.modify("@keyword.return", {
			italic = true,
		})
		hl.modify("@keyword.exception", {
			italic = true,
		})
		hl.modify("@keyword.repeat", {
			italic = true,
		})

		-- Blink.cmp
		if vim.g.blinkcmp_border == "rounded" then
			hl.set("BlinkCmpMenu", {
				link = "Normal",
			})
			hl.set("BlinkCmpMenuBorder", {
				link = "FloatBorder",
			})
		end
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
    MatchWord = {
      underline = true
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
		fn = function()
			local palette = require("gruvbox").palette

			hl.set("Red", { fg = palette.neutral_red }, false)
			hl.set("Orange", { fg = palette.neutral_orange }, false)
			hl.set("Yellow", { fg = palette.neutral_yellow }, false)
			hl.set("Green", { fg = palette.neutral_green }, false)
			hl.set("Purple", { fg = palette.neutral_purple }, false)
			hl.set("Blue", { fg = palette.neutral_blue }, false)
			hl.set("Aqua", { fg = palette.neutral_aqua }, false)

			-- Blink.cmp
			if vim.g.blinkcmp_border == "rounded" then
				hl.set("BlinkCmpMenu", {
					link = "Normal",
				})
				hl.set("BlinkCmpMenuBorder", {
					link = "Normal",
				})
			end
		end,
	})

	hl.set_match("vscode", function()
		local colors = require("vscode.colors").get_colors()
		local fg = colors.vscBack

		-- Syntax
		hl.modify("@keyword.return", {
			italic = true,
		})
		hl.modify("@keyword.exception", {
			italic = true,
		})
		hl.modify("@keyword.repeat", {
			italic = true,
		})
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

	hl.set_match("base46", function()
		local palette = vim.g.base46_palette
		if palette == nil then
			return {}
		end
		local vmode_fg = palette.black
		local normal_bg = hl.dec_to_hex(hl.get("Normal").bg)

		-- Syntax
		hl.modify("@keyword.return", {
			italic = true,
		})
		hl.modify("@keyword.exception", {
			italic = true,
		})
		hl.modify("@keyword.repeat", {
			italic = true,
		})
		hl.modify("@string", {
			italic = true,
		})

		return {
			-- Colors
			Red = {
				fg = palette.base08,
			},
			Orange = {
				fg = palette.base09,
			},
			Yellow = {
				fg = palette.base0A,
			},
			Green = {
				fg = palette.base0B,
			},
			Lime = {
				fg = palette.base0C,
			},
			Blue = {
				fg = palette.blue,
			},
			Cyan = {
				fg = palette.base0D,
			},
			Violet = {
				fg = palette.base0E,
			},
			Gold = {
				fg = palette.base0F,
			},

			-- Diagnostic
			DiagnosticWarn = {
				fg = palette.base0F,
			},
			DiagnosticInfo = {
				fg = palette.cyan,
			},
			DiagnosticHint = {
				fg = palette.purple,
			},
			DiagnosticError = {
				fg = palette.red,
			},
			DiagnosticVirtualTextWarn = {
				fg = palette.base0F,
				bg = hl.blend(palette.base0F, normal_bg, 0.2),
			},
			DiagnosticVirtualTextInfo = {
				fg = palette.cyan,
				bg = hl.blend(palette.cyan, normal_bg, 0.2),
			},
			DiagnosticVirtualTextHint = {
				fg = palette.purple,
				bg = hl.blend(palette.purple, normal_bg, 0.2),
			},
			DiagnosticVirtualTextError = {
				fg = palette.red,
				bg = hl.blend(palette.red, normal_bg, 0.2),
			},
			DiagnosticVirtualLineWarn = {
				link = "DiagnosticVirtualTextWarn",
			},
			DiagnosticVirtualLineInfo = {
				link = "DiagnosticVirtualTextInfo",
			},
			DiagnosticVirtualLineHint = {
				link = "DiagnosticVirtualTextHint",
			},
			DiagnosticVirtualLineError = {
				link = "DiagnosticVirtualTextError",
			},

			-- Diff
			Added = {
				link = "Green",
			},
			Changed = {
				link = "Yellow",
			},
			Removed = {
				link = "Red",
			},

			WarningMsg = {
				link = "Gold",
			},
			FileInfoMod = {
				link = "Gold",
			},

			StatusLineNC = {
				fg = palette.grey_fg,
			},
			StatusLine = {
				bg = palette.black2,
			},
			WinBarNc = {
				bg = palette.one_bg,
			},

			-- BlinkPair
			BlinkPairsUnmatched = {
				fg = palette.red,
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
				link = "Violet",
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
				link = "Violet",
			},
			BlinkIndentOrange = {
				link = "Orange",
			},

			-- Vim mode
			ModeOther = {
				fg = vmode_fg,
				bg = palette.purple,
			},
			ModeNormal = {
				fg = vmode_fg,
				bg = palette.blue,
			},
			ModeInsert = {
				fg = vmode_fg,
				bg = palette.green,
			},
			ModeVisual = {
				fg = vmode_fg,
				bg = palette.baby_pink,
			},
			ModeReplace = {
				fg = vmode_fg,
				bg = palette.red,
			},
			ModeCommand = {
				fg = vmode_fg,
				bg = palette.orange,
			},
		}
	end)

	hl.set_match("vague", function()
		local colors = require("vague").get_palette()

		hl.set("Red", { fg = colors.error })
		hl.set("Orange", { fg = colors.number })
		hl.set("Yellow", { fg = colors.warning })
		hl.set("Green", { fg = colors.plus })
		hl.set("Aqua", { fg = colors.type })
		hl.set("Blue", { fg = colors.keyword })
		hl.set("Purple", { fg = colors.hint })

		return {

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
				link = "Orange",
			},
		}
	end)

	hl.apply()
end

return M
