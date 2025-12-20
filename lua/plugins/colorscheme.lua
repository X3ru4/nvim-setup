local use = vim.cmd.colorscheme

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
	onedark2 = {
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		config = function()
			require("onedarkpro").setup({
				options = {
					cursorline = true, -- Use cursorline highlighting?
					transparency = false, -- Use a transparent background?
					terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
					lualine_transparency = false, -- Center bar transparency?
					highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
				},
				styles = { -- For example, to apply bold and italic, use "bold,italic"
					types = "bold", -- Style that is applied to types
					methods = "bold", -- Style that is applied to methods
					numbers = "NONE", -- Style that is applied to numbers
					strings = "NONE", -- Style that is applied to strings
					comments = "italic", -- Style that is applied to comments
					keywords = "italic", -- Style that is applied to keywords
					constants = "NONE", -- Style that is applied to constants
					functions = "bold", -- Style that is applied to functions
					operators = "NONE", -- Style that is applied to operators
					variables = "NONE", -- Style that is applied to variables
					parameters = "NONE", -- Style that is applied to parameters
					conditionals = "NONE", -- Style that is applied to conditionals
					virtual_text = "NONE", -- Style that is applied to virtual text
				},
			})
			-- onedark
			-- onelight
			-- onedark_vivid
			-- onedark_dark
			-- vaporwave
			use("onedark")
		end,
	},
	catppuccin = {
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
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
	rose_pine = {
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	gruvbox = {
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({})
			use("gruvbox")
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
					link = "MatchParen",
				},
				MatchWordCur = {
					link = "MatchParen",
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
					fg = api.get("ErrorMsg").fg,
				}, true),
				MiniTablineModifiedHidden = {
					link = "MiniTablineModifiedCurrent",
				},
			}
			api.apply_highlight()
		end,
	},
}

local function install(list, setup)
	local t = {}

	local function push(name, opts)
		if name ~= setup then
			local item = { opts[1] }
			if opts.name then
				item.name = opts.name
			end
			table.insert(t, item)
		else
			table.insert(t, opts)
		end
	end

	if type(list) == "table" then
		for _, name in ipairs(list) do
			local opts = colorschemes[name]
			if opts then
				push(name, opts)
			end
		end
	elseif list == "all" then
		for name, opts in pairs(colorschemes) do
			push(name, opts)
		end
	end

	return t
end

-- All the name of colorschemes are the key name in the colorschemes table
return install({
	"tokyonight",
	"catppuccin",
	"kanagawa",
	"onedark2",
	"gruvbox",
}, "kanagawa")
