local M = {}

M.setup = function()
	-- local start = os.clock()
	local hl = require("utility.highlight")
	local normal = {
		fg = hl.dec_to_hex(hl.getfg("Normal")),
		bg = hl.dec_to_hex(hl.getbg("Normal")),
	}

	-- Generate the basic colors with blending for dark variants
	hl.set("Dark1", { fg = hl.blend(normal.bg, normal.fg, 0.9) })
	hl.set("Dark2", { fg = hl.blend(normal.bg, normal.fg, 0.8) })
	hl.set("Dark3", { fg = hl.blend(normal.bg, normal.fg, 0.7) })
	hl.set("Dark4", { fg = hl.blend(normal.bg, normal.fg, 0.6) })

	hl.highlights = {
		-- Custom highlights
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
			bg = hl.getbg("Visual"),
		},

		--- Plugins
		-- MultiCursor
		MultiCursorCursor = { reverse = true },
		MultiCursorVisual = { link = "Visual" },
		MultiCursorSign = { link = "SignColumn" },
		MultiCursorMatchPreview = { link = "Search" },
		MultiCursorDisabledCursor = { reverse = true },
		MultiCursorDisabledVisual = { link = "Visual" },
		MultiCursorDisabledSign = { link = "SignColumn" },

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

		-- BlinkCmp

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
		MiniTablineHidden = {
			link = "StatusLineNC",
		},
		MiniTablineModifiedHidden = hl.modify("MiniTablineHidden", function(base)
			local primary = hl.dec_to_hex(hl.getfg("WarningMsg"))
			local secondary = hl.dec_to_hex(base.fg)
			return {
				bold = true,
				fg = hl.blend(primary, secondary, 0.5),
				bg = base.bg,
			}
		end, true),
		MiniTablineFill = {
			link = "StatusLineNC",
		},

		-- DropBar
		DropBarMenuHoverEntry = {
			link = "Visual",
		},
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
		WinBar = {
			link = "Normal",
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

	hl.set_match("base46!", function(self)
		if vim.g.base46_palette == nil then
			return
		end
		local palette = vim.g.base46_palette
		local dark_fg = palette.black
		local normal_bg = palette.black
		local highlights = {}

		-- Set all the basic colors before return and apply
		hl.set("Red", { fg = palette.base08 })
		hl.set("Orange", { fg = palette.base09 })
		hl.set("Yellow", { fg = palette.base0A })
		hl.set("Green", { fg = palette.base0B })
		hl.set("Aqua", { fg = palette.base0C })
		hl.set("Blue", { fg = palette.base0D })
		hl.set("Purple", { fg = palette.base0E })
		hl.set("Gold", { fg = palette.sun })
		hl.set("Dark0", { fg = palette.black })
		highlights.Dark1 = { fg = palette.base00 }
		highlights.Dark2 = { fg = palette.base01 }
		highlights.Dark3 = { fg = palette.base02 }
		highlights.Dark4 = { fg = palette.base03 }

		-- Support terminal colors
		-- Black & Grey
		vim.g.terminal_color_0 = palette.black2
		vim.g.terminal_color_8 = palette.grey
		-- Red & Bright red
		vim.g.terminal_color_1 = palette.red
		vim.g.terminal_color_9 = palette.baby_pink
		-- Green & Bright green
		vim.g.terminal_color_2 = palette.green
		vim.g.terminal_color_10 = palette.vibrant_green
		-- Yellow & Bright yellow
		vim.g.terminal_color_3 = palette.base09
		vim.g.terminal_color_11 = palette.base0A
		-- Blue & Bright Blue
		vim.g.terminal_color_4 = palette.blue
		vim.g.terminal_color_12 = palette.base0C
		-- Magenta & Bright Magenta
		vim.g.terminal_color_5 = palette.base0E
		vim.g.terminal_color_13 = palette.purple
		-- Cyan & Bright cyan
		vim.g.terminal_color_6 = palette.nord_blue
		vim.g.terminal_color_14 = palette.cyan
		-- White & Gray
		vim.g.terminal_color_7 = palette.base06
		vim.g.terminal_color_15 = palette.base07

		-- Syntax
		hl.modify("@keyword.return", { italic = true })
		hl.modify("@keyword.exception", { italic = true })
		hl.modify("@keyword.repeat", { italic = true })
		highlights["@keyword"] = { fg = hl.getfg("@keyword"), italic = true }
		highlights["@type"] = { fg = palette.vibrant_green }
		highlights.rustKeyword = { link = "@keyword" }
		highlights.Special = { fg = palette.orange }

		-- Nvim
		hl.modify("MatchWord", { fg = "none" })
		hl.modify("Visual", { bold = true })
		highlights.MatchWordCur = { link = "MatchWord" }
		highlights.Yank = { link = "Visual" }
		highlights.DiffAdd = {
			bg = hl.blend(palette.green, normal_bg, 0.2),
		}
		highlights.DiffText = {
			bg = hl.blend(palette.white, normal_bg, 0.2),
		}
		highlights.DiffDelete = {
			bg = hl.blend(palette.red, normal_bg, 0.2),
		}

		-- DropBar
		highlights.DropBarIconKindArray = { link = "Statement" }
		highlights.DropBarIconKindVariable = { fg = palette.base09 }

		-- Fzf-lua
		highlights.FzfLuaBackdrop = { bg = palette.black }

		-- Mini.icons
		highlights.MiniIconsRed = { fg = palette.base08 }
		highlights.MiniIconsOrange = { fg = palette.base09 }
		highlights.MiniIconsYellow = { fg = palette.base0A }
		highlights.MiniIconsPurple = { fg = palette.base0E }
		highlights.MiniIconsGreen = { fg = palette.base0B }
		highlights.MiniIconsCyan = { fg = palette.cyan }
		highlights.MiniIconsBlue = { fg = palette.base0C }
		highlights.MiniIconsAzure = { fg = palette.base0D }
		highlights.MiniIconsGrey = { fg = palette.base05 }

		-- Diagnostic
		highlights.DiagnosticWarn = { fg = palette.yellow }
		highlights.DiagnosticInfo = { fg = palette.cyan }
		highlights.DiagnosticHint = { fg = palette.dark_purple }
		highlights.DiagnosticError = { fg = palette.red }
		highlights.DiagnosticVirtualTextWarn = {
			fg = palette.yellow,
			bg = hl.blend(palette.yellow, normal_bg, 0.2),
		}
		highlights.DiagnosticVirtualTextInfo = {
			fg = palette.cyan,
			bg = hl.blend(palette.cyan, normal_bg, 0.2),
		}
		highlights.DiagnosticVirtualTextHint = {
			fg = palette.dark_purple,
			bg = hl.blend(palette.dark_purple, normal_bg, 0.2),
		}
		highlights.DiagnosticVirtualTextError = {
			fg = palette.red,
			bg = hl.blend(palette.red, normal_bg, 0.2),
		}
		highlights.DiagnosticVirtualLineWarn = { link = "DiagnosticVirtualTextWarn" }
		highlights.DiagnosticVirtualLineInfo = { link = "DiagnosticVirtualTextInfo" }
		highlights.DiagnosticVirtualLineHint = { link = "DiagnosticVirtualTextHint" }
		highlights.DiagnosticVirtualLineError = { link = "DiagnosticVirtualTextError" }

		-- Vanilla
		-- Diff
		highlights.Added = { link = "Green" }
		highlights.Changed = { link = "Yellow" }
		highlights.Removed = { link = "Red" }

		highlights.WarningMsg = { link = "Gold" }
		highlights.StatusLineNC = { fg = palette.grey_fg }
		highlights.StatusLine = { bg = palette.black2 }
		highlights.WinBarNc = { bg = palette.one_bg }
		highlights.NormalFloat = { link = "Normal" }
		highlights.FloatBorder = { bg = hl.getbg("Normal"), fg = palette.grey_fg2 }

		highlights.NonText = { fg = palette.grey_fg }
		highlights.Comment = { fg = palette.grey_fg2, italic = true }

		-- Oil.nvim
		highlights.OilChange = { link = "WarningMsg" }

		-- Lazy
		highlights.LazyReasonCmd = { fg = palette.base09 }
		highlights.LazyReasonEvent = { fg = palette.teal }
		highlights.LazyReasonFt = { fg = palette.green }
		highlights.LazyReasonKeys = { fg = palette.nord_blue }
		highlights.LazyReasonSource = { fg = palette.base0A }
		highlights.LazyReasonPlugin = { fg = palette.dark_purple }
		highlights.LazyReasonStart = { fg = palette.red }

		-- BlinkPair
		highlights.BlinkPairsUnmatched = {
			fg = palette.red,
			reverse = true,
			bold = true,
		}
		highlights.BlinkPairsBlue = { link = "Blue" }
		highlights.BlinkPairsOrange = { link = "Orange" }
		highlights.BlinkPairsPurple = { link = "Purple" }

		-- BlinkIndent
		highlights.BlinkIndentRed = { fg = palette.base08 }
		highlights.BlinkIndentCyan = { fg = palette.base0C }
		highlights.BlinkIndentBlue = { fg = palette.base0D }
		highlights.BlinkIndentGreen = { fg = palette.vibrant_green }
		highlights.BlinkIndentYellow = { fg = palette.base0A }
		highlights.BlinkIndentViolet = { fg = palette.base0E }
		highlights.BlinkIndentOrange = { fg = palette.base09 }

		-- BlinkCmp
		if vim.g.blinkcmp_border == "none" then
			highlights.BlinkCmpMenu = { bg = palette.black2 }
			highlights.BlinkCmpMenuBorder = { fg = palette.grey_fg2, bg = palette.black2 }
		else
			highlights.BlinkCmpMenu = { link = "Normal" }
			highlights.BlinkCmpMenuBorder = { fg = palette.grey_fg2 }
		end
		highlights.BlinkCmpDoc = { link = "BlinkCmpMenu" }
		highlights.BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" }
		highlights.BlinkCmpLabelDescription = { fg = palette.grey }
		highlights.BlinkCmpLabelDetail = { fg = palette.grey }
		highlights.BlinkCmpLabelDeprecated = { fg = palette.grey }
		highlights.BlinkCmpLabel = { fg = palette.white }
		highlights.BlinkCmpLabelMatch = { fg = palette.blue, bold = true }
    highlights.BlinkCmpMenuSelection = { bg = palette.base03 }

		highlights.BlinkCmpKindConstant = { link = "@constant" }
		highlights.BlinkCmpKindField = { link = "@field" }
		highlights.BlinkCmpKindProperty = { link = "@property" }
		highlights.BlinkCmpKindEvent = { link = "@type" }
		highlights.BlinkCmpKindFunction = { link = "@function" }
		highlights.BlinkCmpKindVariable = { link = "@variable.builtin" }
		highlights.BlinkCmpKindMethod = { link = "@method" }
		highlights.BlinkCmpKindConstructor = { link = "@constructor" }
		highlights.BlinkCmpKindReference = { link = "@reference" }
		highlights.BlinkCmpKindKeyword = { fg = palette.orange }
		highlights.BlinkCmpKindText = { fg = palette.green }
		highlights.BlinkCmpKindEnum = { fg = palette.green }
		highlights.BlinkCmpKindClass = { fg = palette.purple }
		highlights.BlinkCmpKindModule = { fg = palette.purple }
		highlights.BlinkCmpKindOperator = { fg = palette.purple }
		highlights.BlinkCmpKindStruct = { fg = palette.yellow }
		highlights.BlinkCmpKindFile = { fg = palette.yellow }
		highlights.BlinkCmpKindUnit = { fg = palette.yellow }
		highlights.BlinkCmpKindSnippet = { fg = palette.dark_purple }
		highlights.BlinkCmpKindFolder = { fg = palette.blue }
		highlights.BlinkCmpKindValue = { fg = palette.blue }
		highlights.BlinkCmpKindEnumMember = { fg = palette.blue }
		highlights.BlinkCmpKindColor = { fg = palette.cyan }
		highlights.BlinkCmpKindTypeParameter = { fg = palette.cyan }
		highlights.BlinkCmpKindInterface = { fg = palette.vibrant_green }
		-- * --

		-- Vim mode
		highlights.ModeOther = {
			fg = dark_fg,
			bg = palette.red,
		}
		highlights.ModeNormal = {
			fg = dark_fg,
			bg = palette.nord_blue,
		}
		highlights.ModeInsert = {
			fg = dark_fg,
			bg = palette.vibrant_green,
		}
		highlights.ModeVisual = {
			fg = dark_fg,
			bg = palette.dark_purple,
		}
		highlights.ModeReplace = {
			fg = dark_fg,
			bg = palette.red,
		}
		highlights.ModeCommand = {
			fg = dark_fg,
			bg = palette.sun,
		}

		local theme = {
			["-chadtain"] = {
				Cursor = { bg = palette.sun },
				TermCursor = { link = "Cursor" },
			},
			["-onedark"] = {
				Cursor = { bg = palette.blue },
				TermCursor = { link = "Cursor" },
			},
			["-doomchad"] = {
				Cursor = { bg = palette.red },
				TermCursor = { link = "Cursor" },
			},
			["-catppuccin"] = {
				["@property"] = {
					fg = palette.lavender,
				},
			},
		}
		if theme[self.variant] then
			highlights = vim.tbl_extend("force", highlights, theme[self.variant])
		end

		return highlights
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

		highlights.MiniStatuslineModeNormal = {
			fg = fg,
			bg = colors.blue,
		}
		highlights.MiniStatuslineModeInsert = {
			fg = fg,
			bg = colors.green,
		}
		highlights.MiniStatuslineModeVisual = {
			fg = fg,
			bg = colors.purple,
		}
		highlights.MiniStatuslineModeCommand = {
			fg = fg,
			bg = colors.orange,
		}
		highlights.MiniStatuslineModeOther = {
			fg = fg,
			bg = colors.green1,
		}
		highlights.MiniStatuslineModeReplace = {
			fg = fg,
			bg = colors.orange,
		}

		return highlights
	end)

	hl.apply()
	-- local elapsed = (os.clock() - start) * 1000
	-- vim.notify(string.format("Highlight configuration applied in %.2f ms", elapsed), vim.log.levels.INFO)
end

return M
