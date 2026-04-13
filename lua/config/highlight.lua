local M = {}

M.setup = function()
	local hl = require("utility.highlight")
	local normal = {
		fg = hl.getfg("Normal"),
		bg = hl.getbg("Normal"),
	}
	local normal_extra = {
		fg = normal.fg or hl.getfg("TroubleText"),
		bg = normal.bg or hl.getfg("Search"),
	}

	-- Generate the basic colors with blending for dark variants
	hl.set("Dark1", { fg = hl.blend(normal_extra.bg, normal_extra.fg, 0.9) })
	hl.set("Dark2", { fg = hl.blend(normal_extra.bg, normal_extra.fg, 0.8) })
	hl.set("Dark3", { fg = hl.blend(normal_extra.bg, normal_extra.fg, 0.7) })
	hl.set("Dark4", { fg = hl.blend(normal_extra.bg, normal_extra.fg, 0.6) })

	hl.highlights = {
		-- Custom highlights
		ModeOther = { link = "MiniStatuslineModeOther" },
		ModeNormal = { link = "MiniStatuslineModeNormal" },
		ModeInsert = { link = "MiniStatuslineModeInsert" },
		ModeVisual = { link = "MiniStatuslineModeVisual" },
		ModeReplace = { link = "MiniStatuslineModeReplace" },
		ModeCommand = { link = "MiniStatuslineModeCommand" },
		Yank = { bg = hl.getbg("Visual") },

		--- Plugins
		-- FzfLua
		FzfLuaHeaderText = { link = "ErrorMsg" },
		FzfLuaBufFlagCur = { link = "ErrorMsg" },
		FzfLuaLiveSym = { link = "ErrorMsg" },
		FzfLuaLivePrompt = { link = "ErrorMsg" },
		FzfLuaPathColNr = { link = "Directory" },
		FzfLuaBufFlagAlt = { link = "Directory" },
		FzfLuaTabTitle = { link = "Directory" },
		FzfLuaBufNr = { link = "WarningMsg" },
		FzfLuaHeaderBind = { link = "WarningMsg" },
		FzfLuaTabMarker = { link = "WarningMsg" },
		FzfLuaBorder = { link = "Normal" },

		-- MiniTabline
		MiniTablineCurrent = {
			fg = normal.fg,
			bg = normal.bg,
			bold = true,
		},
		MiniTablineModifiedCurrent = {
			fg = hl.getfg("WarningMsg"),
			bg = normal.bg,
			bold = true,
		},
		MiniTablineHidden = { link = "TabLineNC" },
		MiniTablineModifiedHidden = hl.modify("TabLineNC", function(base)
			return {
				bold = true,
				fg = hl.blend(hl.getfg("WarningMsg"), base.fg, 0.5),
				bg = base.bg,
			}
		end),
		MiniTablineFill = { link = "TabLineNC" },

		-- DropBar
		DropBarMenuHoverEntry = { link = "Visual" },
		DropBarMenuHoverIcon = vim.empty_dict(),
		hl.modify("DropBarIconUISeparator", {
			italic = false,
		}),
		hl.modify("DropBarIconUISeparatorNC", {
			italic = false,
		}),
		hl.modify("DropBarIconUISeparatorMenu", {
			italic = false,
		}),

		-- Vanilla
		WinBar = { link = "Normal" },
		SpellBad = { strikethrough = true },
		SpellCap = { strikethrough = true },
		SpellRare = { strikethrough = true },
		SpellLocal = { strikethrough = true },
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
			fg = hl.getfg("Red"),
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
			fg = hl.getfg("Red"),
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

			Cursor = {
				bg = hl.getfg("blue"),
			},

			-- BlinkPair
			BlinkPairsUnmatched = {
				fg = hl.getfg("red"),
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
		-- BlinkPair
		BlinkPairsUnmatched = {
			fg = hl.getfg("red"),
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
			local palette = {}
			local lazy = require("utility.lazy")
			if lazy.plugin_loaded("kanagawa") then
				palette = require("kanagawa.colors").setup().palette
			else
				palette = require("kanagawa-paper.colors").setup().palette
			end

			hl.set("Red", { fg = palette.peachRed }, false)
			hl.set("Orange", { fg = palette.roninYellow }, false)
			hl.set("Yellow", { fg = palette.lotusYellow4 }, false)
			hl.set("Green", { fg = palette.springGreen }, false)
			hl.set("Purple", { fg = palette.oniViolet }, false)
			hl.set("Blue", { fg = palette.crystalBlue }, false)
			hl.set("Aqua", { fg = palette.springBlue }, false)

			hl.modify("DropBarIconUISeparator", {
				italic = false,
			})
			hl.modify("DropBarIconUISeparatorNC", {
				italic = false,
			})
			hl.modify("DropBarIconUISeparatorMenu", {
				italic = false,
			})
		end,
	})

	hl.set_match("gruvbox", {
		Cursor = {
			bg = hl.getfg("Orange"),
		},
		SignColumn = {
			link = "Normal",
		},
		CursorLineSign = {
			link = "CursorLine",
		},
		MatchWord = {
			underline = true,
		},

		-- BlinkPair
		BlinkPairsUnmatched = {
			fg = hl.getfg("red"),
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
		fn = function()
			local palette = require("gruvbox").palette

			hl.set("Red", { fg = palette.bright_red }, false)
			hl.set("Orange", { fg = palette.bright_orange }, false)
			hl.set("Yellow", { fg = palette.bright_yellow }, false)
			hl.set("Green", { fg = palette.bright_green }, false)
			hl.set("Purple", { fg = palette.bright_purple }, false)
			hl.set("Blue", { fg = palette.bright_blue }, false)
			hl.set("Aqua", { fg = palette.bright_aqua }, false)
			hl.set("dark1", { fg = palette.dark1 }, false)
			hl.set("dark2", { fg = palette.dark2 }, false)
			hl.set("dark3", { fg = palette.dark3 }, false)
			hl.set("dark4", { fg = palette.dark4 }, false)

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
			},
			ModeNormal = {
				bg = colors.vscBlue,
				fg = fg,
			},
			ModeInsert = {
				bg = colors.vscGreen,
				fg = fg,
			},
			ModeVisual = {
				bg = colors.vscPink,
				fg = fg,
			},
			ModeReplace = {
				bg = colors.vscLightRed,
				fg = fg,
			},
			ModeCommand = {
				bg = colors.vscOrange,
				fg = fg,
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

			Changed = {
				fg = colors.vscYellow,
			},
			Removed = {
				fg = colors.vscRed,
			},
		}
	end)

	hl.set_match("vague", function()
		local colors = require("vague").get_palette()

		local red = colors.error
		local orange = colors.number
		local yellow = colors.warning
		local green = colors.plus
		local aqua = colors.keyword
		local blue = colors.hint
		local purple = colors.parameter

		return {

			-- BlinkPair
			BlinkPairsUnmatched = {
				fg = red,
				reverse = true,
				bold = true,
			},
			BlinkPairsBlue = { fg = blue },
			BlinkPairsOrange = { fg = orange },
			BlinkPairsPurple = { fg = purple },

			-- BlinkIndent
			BlinkIndentRed = { fg = red },
			BlinkIndentCyan = { fg = aqua },
			BlinkIndentBlue = { fg = blue },
			BlinkIndentGreen = { fg = green },
			BlinkIndentYellow = { fg = yellow },
			BlinkIndentViolet = { fg = purple },
			BlinkIndentOrange = { fg = orange },

			-- Blink.cmp
			BlinkCmpMenu = {
				link = "Normal",
			},
			BlinkCmpMenuSelection = {
				bg = colors.line,
			},
			BlinkCmpDoc = {
				link = "Normal",
			},

			-- MiniClues
			MiniClueSeparator = {
				fg = colors.parameter,
			},

			-- MiniIcons
			MiniIconsRed = { fg = red },
			MiniIconsOrange = { fg = orange },
			MiniIconsYellow = { fg = yellow },
			MiniIconsPurple = { fg = purple },
			MiniIconsGreen = { fg = green },
			MiniIconsCyan = { fg = aqua },
			MiniIconsBlue = { fg = blue },
			MiniIconsAzure = { fg = aqua },
			MiniIconsGrey = { fg = colors.comment },
		}
	end)

	hl.set_match("!fox", function(self)
		local palette = require("nightfox.palette." .. self.theme).palette

		-- Basic colors
		hl.set("Red", { fg = palette.red.base })
		hl.set("Orange", { fg = palette.orange.base })
		hl.set("Yellow", { fg = palette.yellow.base })
		hl.set("Green", { fg = palette.green.base })
		hl.set("Aqua", { fg = palette.cyan.base })
		hl.set("Blue", { fg = palette.blue.base })
		hl.set("Purple", { fg = palette.magenta.base })

		return {

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
			BlinkCmpKind = {
				fg = hl.getfg("PmenuKind"),
			},

			-- Vanilla
			NormalFloat = {
				link = "Normal",
			},
		}
	end)

	hl.set_match("tokyonight!", function()
		local colors = require("tokyonight.colors").setup()
		local fg = colors.black
		local highlights = {}

		highlights.ModeNormal = {
			fg = fg,
			bg = colors.blue,
		}
		highlights.ModeInsert = {
			fg = fg,
			bg = colors.green,
		}
		highlights.ModeVisual = {
			fg = fg,
			bg = colors.purple,
		}
		highlights.ModeCommand = {
			fg = fg,
			bg = colors.orange,
		}
		highlights.ModeOther = {
			fg = fg,
			bg = colors.green1,
		}
		highlights.ModeReplace = {
			fg = fg,
			bg = colors.orange,
		}

		return highlights
	end)

	hl.set_match("rusty", function()
		local highlights = {}
		local colors = require("rusty.colors").get()
		local fg = colors.background

		highlights.ModeNormal = {
			fg = fg,
			bg = colors.blue,
		}
		highlights.ModeInsert = {
			fg = fg,
			bg = colors.green,
		}
		highlights.ModeVisual = {
			fg = fg,
			bg = colors.purple,
		}
		highlights.ModeCommand = {
			fg = fg,
			bg = colors.orange,
		}
		highlights.ModeOther = {
			fg = fg,
			bg = colors.aqua,
		}
		highlights.ModeReplace = {
			fg = fg,
			bg = colors.red,
		}

		highlights.MiniIconsRed = { fg = colors.red }
		highlights.MiniIconsOrange = { fg = colors.orange }
		highlights.MiniIconsYellow = { fg = colors.yellow }
		highlights.MiniIconsPurple = { fg = colors.purple }
		highlights.MiniIconsGreen = { fg = colors.green }
		highlights.MiniIconsCyan = { fg = colors.aqua }
		highlights.MiniIconsBlue = { fg = colors.blue }
		highlights.MiniIconsAzure = { fg = colors.aqua }
		highlights.MiniIconsGrey = { fg = colors.comment }

		highlights.MiniTablineModifiedCurrent = {
			fg = colors.red,
			bg = colors.background,
			bold = true,
		}
		highlights.MiniTablineModifiedHidden = {
			fg = hl.blend(colors.red, colors.line, 0.8),
			bg = colors.line,
		}

		highlights.BlinkCmpLabel = { fg = colors.foreground, bg = colors.background }
		highlights.BlinkCmpLabelDescription = { fg = colors.comment }
		highlights.BlinkCmpLabelDetail = { fg = colors.comment }
		highlights.BlinkCmpLabelDeprecated = { fg = colors.comment }
		highlights.BlinkCmpLabelMatch = { fg = colors.blue, bold = true }
		highlights.BlinkCmpMenu = { bg = colors.background }
		highlights.BlinkCmpMenuSelection = { bg = colors.selection }
		highlights.BlinkCmpMenuBorder = { bg = colors.background }
		highlights.BlinkCmpKind = { fg = colors.foreground }
		highlights.BlinkCmpKindConstant = { link = "@constant" }
		highlights.BlinkCmpKindProperty = { link = "@property" }
		highlights.BlinkCmpKindFunction = { link = "@function" }
		highlights.BlinkCmpKindMethod = { link = "@method" }
		highlights.BlinkCmpKindConstructor = { link = "@constructor" }
		highlights.BlinkCmpKindReference = { link = "@reference" }
		highlights.BlinkCmpKindField = { fg = colors.orange }
		highlights.BlinkCmpKindVariable = { fg = colors.orange }
		highlights.BlinkCmpKindKeyword = { fg = colors.orange }
		highlights.BlinkCmpKindEvent = { fg = colors.green }
		highlights.BlinkCmpKindText = { fg = colors.green }
		highlights.BlinkCmpKindEnum = { fg = colors.green }
		highlights.BlinkCmpKindClass = { fg = colors.purple }
		highlights.BlinkCmpKindModule = { fg = colors.purple }
		highlights.BlinkCmpKindSnippet = { fg = colors.purple }
		highlights.BlinkCmpKindOperator = { fg = colors.purple }
		highlights.BlinkCmpKindStruct = { fg = colors.yellow }
		highlights.BlinkCmpKindFile = { fg = colors.yellow }
		highlights.BlinkCmpKindUnit = { fg = colors.yellow }
		highlights.BlinkCmpKindFolder = { fg = colors.blue }
		highlights.BlinkCmpKindValue = { fg = colors.blue }
		highlights.BlinkCmpKindEnumMember = { fg = colors.aqua }
		highlights.BlinkCmpKindColor = { fg = colors.aqua }
		highlights.BlinkCmpKindTypeParameter = { fg = colors.aqua }
		highlights.BlinkCmpKindInterface = { fg = colors.aqua }

		highlights.BlinkPairsUnmatched = {
			fg = colors.red,
			reverse = true,
			bold = true,
		}
		highlights.BlinkPairsBlue = {
			fg = colors.blue,
		}
		highlights.BlinkPairsOrange = {
			fg = colors.orange,
		}
		highlights.BlinkPairsPurple = {
			fg = colors.purple,
		}

		highlights.BlinkIndentRed = {
			fg = colors.red,
		}
		highlights.BlinkIndentCyan = {
			fg = colors.aqua,
		}
		highlights.BlinkIndentBlue = {
			fg = colors.blue,
		}
		highlights.BlinkIndentGreen = {
			fg = colors.green,
		}
		highlights.BlinkIndentYellow = {
			fg = colors.yellow,
		}
		highlights.BlinkIndentViolet = {
			fg = colors.purple,
		}
		highlights.BlinkIndentOrange = {
			fg = colors.orange,
		}

		highlights.DiagnosticError = {
			fg = colors.red,
		}
		highlights.DiagnosticWarn = {
			fg = colors.yellow,
		}
		highlights.DiagnosticInfo = {
			fg = colors.blue,
		}
		highlights.DiagnosticHint = {
			fg = colors.purple,
		}
		highlights.Added = {
			fg = colors.green,
		}
		highlights.Changed = {
			fg = colors.yellow,
		}
		highlights.Removed = {
			fg = colors.red,
		}
		highlights.WinBarNC = {
			bg = colors.background,
		}
		highlights.TabLineNC = {
			fg = colors.foreground,
			bg = colors.line,
		}
		highlights.TabLine = {
			fg = colors.foreground,
			bg = colors.line,
		}
		highlights.StatusLine = {
			fg = colors.foreground,
		}

		-- Black & Grey
		vim.g.terminal_color_0 = colors.background
		vim.g.terminal_color_8 = colors.window
		-- Red & Bright red
		vim.g.terminal_color_1 = colors.red
		vim.g.terminal_color_9 = colors.red
		-- Green & Bright green
		vim.g.terminal_color_2 = colors.green
		vim.g.terminal_color_10 = colors.green
		-- Yellow & Bright yellow
		vim.g.terminal_color_3 = colors.yellow
		vim.g.terminal_color_11 = colors.yellow
		-- Blue & Bright Blue
		vim.g.terminal_color_4 = colors.blue
		vim.g.terminal_color_12 = colors.blue
		-- Magenta & Bright Magenta
		vim.g.terminal_color_5 = colors.purple
		vim.g.terminal_color_13 = colors.purple
		-- Cyan & Bright cyan
		vim.g.terminal_color_6 = colors.aqua
		vim.g.terminal_color_14 = colors.aqua
		-- White & Gray
		vim.g.terminal_color_7 = colors.foreground
		vim.g.terminal_color_15 = colors.comment

		return highlights
	end)

	hl.set_match("shale", function()
		local colors = require("shale.colors")

		-- Black & Grey
		vim.g.terminal_color_0 = colors.bg
		vim.g.terminal_color_8 = colors.bg_alt
		-- Red & Bright red
		vim.g.terminal_color_1 = colors.error
		vim.g.terminal_color_9 = colors.error
		-- Green & Bright green
		vim.g.terminal_color_2 = colors.git_add
		vim.g.terminal_color_10 = colors.git_add
		-- Yellow & Bright yellow
		vim.g.terminal_color_3 = colors.git_change
		vim.g.terminal_color_11 = colors.git_change
		-- Blue & Bright Blue
		vim.g.terminal_color_4 = colors.hint
		vim.g.terminal_color_12 = colors.hint
		-- Magenta & Bright Magenta
		vim.g.terminal_color_5 = colors.keyword
		vim.g.terminal_color_13 = colors.keyword
		-- Cyan & Bright cyan
		vim.g.terminal_color_6 = colors.func
		vim.g.terminal_color_14 = colors.func
		-- White & Gray
		vim.g.terminal_color_7 = colors.fg
		vim.g.terminal_color_15 = colors.fg_dim

		return {
			BlinkPairsUnmatched = {
				fg = colors.error,
				reverse = true,
				bold = true,
			},
			BlinkPairsBlue = {
				fg = colors.hint,
			},
			BlinkPairsOrange = {
				fg = colors.number,
			},
			BlinkPairsPurple = {
				fg = colors.keyword,
			},
			BlinkIndentRed = {
				fg = colors.error,
			},
			BlinkIndentCyan = {
				fg = colors.func,
			},
			BlinkIndentBlue = {
				fg = colors.hint,
			},
			BlinkIndentGreen = {
				fg = colors.git_add,
			},
			BlinkIndentYellow = {
				fg = colors.git_change,
			},
			BlinkIndentViolet = {
				fg = colors.keyword,
			},
			BlinkIndentOrange = {
				fg = colors.number,
			},

			FloatBorder = {
				fg = colors.border,
				bg = hl.getbg("NormalFloat"),
			},

			BlinkCmpMenu = { link = "CmpItemMenu" },
			BlinkCmpMenuBorder = {
				fg = colors.border,
				bg = hl.getbg("Normal"),
			},
			BlinkCmpMenuSelection = {
				bg = colors.selection,
			},
		}
	end)

	hl.apply()
end

return M
