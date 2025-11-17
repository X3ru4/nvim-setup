local function use(name)
	vim.cmd.colorscheme(name)
end

-- Add colorscheme here

local colorschemes = {

	tokyonight = {
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").load({
				style = "moon",
			})
		end,
	},
	onedark = {
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",
				ending_tildes = true,
			})
			require("onedark").load()
		end,
	},
	catppuccin = {
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				transparent_background = false, -- disables setting the background color.
				no_italic = true,
				float = {
					transparent = false, -- enable transparent floating windows
					solid = false, -- use solid styling for floating windows, see |winborder|
				},
			})
			use("catppuccin")
		end,
	},
	nord = {
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.nord_contrast = true
			require("nord").set()
		end,
	},
	nordic = {
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	nordern = {
		"fcancelinha/nordern.nvim",
		branch = "master",
		priority = 1000,
		config = function()
			require("nordern").setup({
				brighter_constants = false,
			})
			use("nordern")
		end,
	},
	kanagawa = {
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	sonokai = {
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_style = "atlantis"
			vim.g.sonokai_enable_italic = true
			use("sonokai")
		end,
	},
	nightfox = {
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			use("nightfox")
		end,
	},
	material = {
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			use("material-deep-ocean")
		end,
	},
	cyberdream = {
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			use("cyberdream")
		end,
	},
	base46 = {
		"jayden-chan/base46.nvim",
		lazy = false,
		config = function()
			require("base46").load_theme({
				base = "base46",
				-- Available theme in _base46_theme.txt
				theme = "onedark",
				transparency = false,
			})
			local set_hl = vim.api.nvim_set_hl
			local api = require("../config/highlight_api")
			api.highlights = {
				WinBar = {
					link = "Normal",
				},
				WinBarNC = {
					link = "Normal",
				},
        MatchParenCur = {
          link = "MatchParen"
        },
        MatchWordCur = {
          link = "MatchParen"
        },
				DropBarIconUISeparator = {
					fg = api.get("Comment").fg,
				},
				DropBarIconUISeparatorNC = {
					link = "DropBarIconUISeparator",
				},
				DropBarIconUISeparatorMenu = {
					link = "DropBarIconUISeparator",
				},
				MiniStatuslineModeInsert = api.modify("Feline_InsertMode", {
					reverse = true,
					bold = true,
				}, true),
				MiniStatuslineModeNormal = api.modify("Feline_NormalMode", {
					reverse = true,
					bold = true,
				}, true),
				MiniStatuslineModeVisual = api.modify("Feline_VisualMode", {
					reverse = true,
					bold = true,
				}, true),
				MiniStatuslineModeCommand = api.modify("Feline_CommandMode", {
					reverse = true,
					bold = true,
				}, true),
				MiniStatuslineModeReplace = api.modify("Feline_ReplaceMode", {
					reverse = true,
					bold = true,
				}, true),
				MiniStatuslineModeOther = api.modify("Feline_ConfirmMode", {
					reverse = true,
					bold = true,
				}, true),
				MiniDiffSignAdd = {
					link = "GitSignsAdd",
				},
				MiniDiffSignChange = {
					link = "GitSignsChange",
				},
				MiniDiffSignDelete = {
					link = "GitSignsDelete",
				},
        MiniTablineModifiedCurrent = api.modify("TabLineSel", {
          fg = api.get("ErrorMsg").fg
        }, true),
        MiniTablineModifiedHidden = {
          link = "MiniTablineModifiedCurrent"
        }
			}
			api.apply_highlight()
		end,
	},
}

return colorschemes.nordern
