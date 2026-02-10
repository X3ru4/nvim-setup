local hl = require("utility.highlight")
local c = {}

c = {
	tokyonight = {
		"folke/tokyonight.nvim",
		event = "UiEnter",
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
		event = "UiEnter",
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
		event = "UiEnter",
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
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.g.nord_contrast = true
			vim.g.blinkcmp_border = "none"
			require("nord").set()
			hl.set("WinBarNC", { link = "WinBar" })
		end,
	},
	edge = {
		"sainnhe/edge",
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "none"
			vim.g.edge_transparent_background = 0
			vim.g.edge_enable_italic = 0
			vim.g.edge_ui_contrast = "hight" -- "low"|"high"
			vim.g.edge_show_eob = 1
			-- Available values "bright"|"dim"|"blend"
			vim.g.edge_float_style = "blend"
			-- Can ve set with "default"|"aura"|"neon"
			vim.g.edge_style = "default"
			-- Available values "grey background"|"high contrast background"|"bold"|"underline"|"italic"
			vim.g.edge_current_word = "grey background"
			-- Available values "grey"|"colored"|"highlighted"
			vim.g.edge_diagnostic_virtual_text = "highlighted"
			vim.g.edge_better_performance = 1
			-- Available values "none"|"dimmed"
			vim.g.edge_inlay_hints_background = "none"
			vim.cmd.colorscheme("edge")
		end,
	},
	everforest = {
		"sainnhe/everforest",
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "none"
			vim.g.everforest_transparent_background = 0
			vim.g.everforest_enable_bold = 1
			vim.g.everforest_enable_italic = 0
			vim.g.everforest_ui_contrast = "high" -- "low"|"high"
			vim.g.everforest_show_eob = 2
			-- Available values "bright"|"dim"|"blend"
			vim.g.everforest_float_style = "blend"
			-- Can ve set with "hard"|"medium"|"soft"
			vim.g.everforest_background = "hard"
			-- Available values "grey background"|"high contrast background"|"bold"|"underline"|"italic"
			vim.g.everforest_current_word = "grey background"
			-- Available values "grey"|"colored"|"highlighted"
			vim.g.everforest_diagnostic_virtual_text = "highlighted"
			vim.g.everforest_better_performance = 1
			-- Available values "none"|"dimmed"
			vim.g.everforest_inlay_hints_background = "none"
			vim.cmd.colorscheme("everforest")
		end,
	},
	gruvbox_material = {
		"sainnhe/gruvbox-material",
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "rounded"
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1
			-- Available values 'grey background'|"green background"|"blue background"|"red background"|"reverse"
			vim.g.gruvbox_material_visual = "green background"
			-- Available values "material"|"mix"|"original"
			vim.g.gruvbox_material_foreground = "original"
			-- Available values "hard"|"medium"|"soft"
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_ui_contrast = "high" -- "low"|"high"
			-- Available values "grey background"|"high contrast background"|"bold"|"underline"|"italic"
			vim.g.gruvbox_material_current_word = "grey background"
			vim.g.gruvbox_material_show_eob = 1
			-- Available values "bright"|"dim"|"blend"
			vim.g.gruvbox_material_float_style = "blend"
			-- Available values "grey"|"colored"|"highlighted"
			vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
			vim.g.gruvbox_material_better_performance = 1
			-- Available values "none"|"dimmed"
			vim.g.gruvbox_material_inlay_hints_background = "none"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	gruvbox = {
		"ellisonleao/gruvbox.nvim",
		event = "UiEnter",
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
				transparent_mode = true,
			})
			local palette = require("gruvbox").palette

			hl.set("Red", { fg = palette.neutral_red }, false)
			hl.set("Orange", { fg = palette.neutral_orange }, false)
			hl.set("Yellow", { fg = palette.neutral_yellow }, false)
			hl.set("Green", { fg = palette.neutral_green }, false)
			hl.set("Purple", { fg = palette.neutral_purple }, false)
			hl.set("Blue", { fg = palette.neutral_blue }, false)
			hl.set("Aqua", { fg = palette.neutral_aqua }, false)

			vim.g.blinkcmp_border = "none"
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	kanagawa = {
		"rebelot/kanagawa.nvim",
		event = "UiEnter",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				undercurl = true,
				commentStyle = { italic = true, bold = false },
				functionStyle = { bold = true },
				keywordStyle = { italic = true },
			})
			vim.g.blinkcmp_border = "none"
			local palette = require("kanagawa.colors").setup().palette

			hl.set("Red", { fg = palette.canvasRed1 }, false)
			hl.set("Orange", { fg = palette.canvasOrange1 }, false)
			hl.set("Yellow", { fg = palette.canvasYellow1 }, false)
			hl.set("Green", { fg = palette.canvasGreen1 }, false)
			hl.set("Purple", { fg = palette.canvasPink1 }, false)
			hl.set("Blue", { fg = palette.canvasBlue1 }, false)
			hl.set("Aqua", { fg = palette.canvasAqua1 }, false)
			require("kanagawa").load()
		end,
	},
	kanagawa_paper = {
		"thesimonho/kanagawa-paper.nvim",
		event = "UiEnter",
		priority = 1000,
		config = function()
			require("kanagawa-paper").setup({
				cache = true,
			})
			vim.g.blinkcmp_border = "none"
			require("kanagawa-paper").load()
		end,
	},
	nightfox = {
		"EdenEast/nightfox.nvim",
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "none"
			vim.cmd.colorscheme("nightfox")
		end,
	},
	material = {
		"marko-cerovac/material.nvim",
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("material-deep-ocean")
		end,
	},
	cyberdream = {
		"scottmckendry/cyberdream.nvim",
		event = "UiEnter",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("cyberdream")
		end,
	},
	vscode = {
		"Mofiqul/vscode.nvim",
		event = "UiEnter",
		priority = 1000,
		config = function()
			require("vscode").setup({
				transparent = false,
				italic_comments = false,
				italic_inlayhints = true,
				underline_links = true,
				disable_nvimtree_bg = false,
			})
			require("vscode").load("dark")
		end,
	},
	based46 = {
		"jayden-chan/base46.nvim",
		event = "VimEnter",
		priority = 1000,
		config = function()
			-- exit if it can't be found
			local present, base46 = pcall(require, "base46")
			if not present then
				return
			end

      -- Press gf to go the folder
			-- All availables theme at ~/.local/share/nvim/lazy/base46.nvim/lua/base46/hl_themes/
			local theme = "gruvchad"
			local color_base = "base46"

			local theme_opts = {
				base = color_base,
				theme = theme,
				transparency = false, -- Unrecomment at now
			}

			local palette = base46.get_colors(color_base, theme)
			vim.g.colors_name = "base46"
			vim.g.base46_palette = palette

			base46.load_theme(theme_opts)
		end,
	},
}

-- Super clean =))
local cs = require("utility.colorscheme")

-- Recomment lever = index
cs.list = {
	c.gruvbox_material, -- Recomment!
	c.edge, -- Recomment! Better than onedark
	c.everforest, -- Recomment!
	c.vscode, -- Recomment!
	c.catppuccin, -- Recomment!
	c.gruvbox, -- Recomment!
	c.kanagawa, -- Recomment!
	c.cyberdream, -- Recomment!
	c.kanagawa_paper, -- Recomment!
	c.nord, -- Recomment!
	c.tokyonight, -- Hmmmmm!
	c.onedark, -- Hmmmmm!
	c.nightfox, -- Hmmmmm!
	c.based46, -- Hmmmmm!
}

return cs.install_(c.based46)
