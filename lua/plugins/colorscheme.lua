local hl = require("utility.highlight")
local c = {}

c = {
	tokyonight = {
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").load({
				style = "moon",
			})

			local colors = require("tokyonight.colors").setup()
			local fg = colors.black

			hl.set("MiniStatuslineModeNormal", {
				fg = fg,
				bg = colors.blue,
			})
			hl.set("MiniStatuslineModeInsert", {
				fg = fg,
				bg = colors.green,
			})
			hl.set("MiniStatuslineModeVisual", {
				fg = fg,
				bg = colors.purple,
			})
			hl.set("MiniStatuslineModeCommand", {
				fg = fg,
				bg = colors.orange,
			})
			hl.set("MiniStatuslineModeOther", {
				fg = fg,
				bg = colors.green1,
			})
			hl.set("MiniStatuslineModeReplace", {
				fg = fg,
				bg = colors.orange,
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
				no_italic = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = { "italic" },
					functions = { "bold" },
					keywords = { "italic" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = { "bold" },
					operators = {},
				},
				float = {
					transparent = false, -- enable transparent floating windows
					solid = false, -- use solid styling for floating windows, see |winborder|
				},
				integrations = {
					blink_cmp = true,
					leap = true,
					mason = true,
					dropbar = {
						enabled = true,
						color_mode = false, -- enable color for kind's texts, not just kind's icons
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	nord = {
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.nord_contrast = true
			vim.g.blinkcmp_border = "none"
			require("nord").set()
			hl.set("WinBarNC", { link = "WinBar" })
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
			vim.cmd.colorscheme("nordern")
		end,
	},
	rose_pine = {
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	gruvbox_material = {
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox-material")
			vim.g.blinkcmp_border = "none"
		end,
	},
	gruvbox = {
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.g.blinkcmp_border = "none"
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	kanagawa = {
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				undercurl = true,
				commentStyle = { italic = true, bold = false },
				functionStyle = { bold = true },
				keywordStyle = { italic = true },
			})
			vim.g.blinkcmp_border = "none"
			require("kanagawa").load()
		end,
	},
	kanagawa_paper = {
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa-paper").setup({
				cache = true,
			})
			vim.g.blinkcmp_border = "none"
			require("kanagawa-paper").load()
		end,
	},
	sonokai = {
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_style = "atlantis"
			vim.g.sonokai_enable_italic = true
			vim.cmd.colorscheme("sonokai")
		end,
	},
	nightfox = {
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "none"
			vim.cmd.colorscheme("nightfox")
		end,
	},
	material = {
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("material-deep-ocean")
		end,
	},
	cyberdream = {
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("cyberdream")
		end,
	},
	vscode = {
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").load("dark")
			local colors = require("vscode.colors").get_colors()

			local fg = colors.vscBack
			hl.highlights_extra = {
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
					strikethrough = true,
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
		end,
	},
	github = {
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				-- ...
			})

			vim.cmd.colorscheme("github_dark_dimmed")
		end,
	},
}

-- Super clean =))
local cs = require("utility.colorscheme")

cs.list = {
	c.catppuccin, -- Recomment!
	c.kanagawa, -- Recomment!
	c.gruvbox, -- Recomment!
	c.kanagawa_paper, -- Recomment!
	c.vscode, -- Recomment!
	c.cyberdream, -- Recomment!
	c.nord, -- Recomment!
	c.rose_pine, -- Recomment!
	c.gruvbox_material, -- Recomment!
	c.tokyonight, -- Hmmmmm!
	c.onedark, -- Hmmmmm!
	c.github, -- Hmmmmm!
	c.nightfox, -- Hmmmmm!
}

return cs.install_(c.gruvbox_material)
