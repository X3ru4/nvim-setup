local hl = require("utility.highlight")
local c = {}

vim.g.blinkcmp_border = nil

c = {
	tokyonight = {
		"folke/tokyonight.nvim",
		name = "tokyonight",
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
		name = "onedark",
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
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	nord = {
		"shaunsingh/nord.nvim",
		name = "nord",
		lazy = false,
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
		name = "edge",
		event = "VimEnter",
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "none"
			vim.g.edge_transparent_background = 0
			vim.g.edge_enable_italic = 1
			vim.g.edge_ui_contrast = "hight" -- "low"|"high"
			vim.g.edge_show_eob = 1
			-- Available values "bright"|"dim"|"blend"
			vim.g.edge_float_style = "blend"
			-- Can ve set with "default"|"aura"|"neon"
			vim.g.edge_style = "default"
			-- Available values "grey background"|"high contrast background"|"bold"|"underline"|"italic"
			vim.g.edge_current_word = "grey background"
			-- Available values "grey"|"colored"|"highlighted"
			vim.g.edge_diagnostic_virtual_text = "colored"
			vim.g.edge_better_performance = 1
			-- Available values "none"|"dimmed"
			vim.g.edge_inlay_hints_background = "none"
			vim.cmd.colorscheme("edge")
		end,
	},
	everforest = {
		"sainnhe/everforest",
		name = "everforest",
		event = "VimEnter",
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
		name = "gruvbox-material",
		event = "VimEnter",
		priority = 1000,
		config = function()
			vim.g.blinkcmp_border = "rounded"
			vim.g.gruvbox_material_transparent_background = 0
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1
			-- Available values 'grey background'|"green background"|"blue background"|"red background"|"reverse"
			vim.g.gruvbox_material_visual = "green background"
			-- Available values "material"|"mix"|"original"
			vim.g.gruvbox_material_foreground = "mix"
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
		name = "gruvbox",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
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
				contrast = "soft", -- can be "hard", "soft" or empty string
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
		name = "kanagawa",
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
		name = "kanagawa-paper",
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
	nightfox = {
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					-- Compiled file's destination location
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled", -- Compiled file suffix
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					module_default = true, -- Default enable value for modules
					colorblind = {
						enable = false, -- Enable colorblind support
						simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
						severity = {
							protan = 0, -- Severity [0,1] for protan (red)
							deutan = 0, -- Severity [0,1] for deutan (green)
							tritan = 0, -- Severity [0,1] for tritan (blue)
						},
					},
					styles = { -- Style to be applied to different syntax groups
						comments = "italic", -- Value is any valid attr-list value `:help attr-list`
						conditionals = "NONE",
						constants = "bold",
						functions = "bold",
						keywords = "italic",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "italic",
						variables = "NONE",
					},
					inverse = { -- Inverse highlight for different types
						match_paren = false,
						visual = false,
						search = false,
					},
				},
			})

			vim.g.blinkcmp_border = "none"
			vim.cmd.colorscheme("duskfox")
		end,
	},
	material = {
		"marko-cerovac/material.nvim",
		name = "material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("material-deep-ocean")
		end,
	},
	cyberdream = {
		"scottmckendry/cyberdream.nvim",
		name = "cyberdream",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("cyberdream")
		end,
	},
	vscode = {
		"Mofiqul/vscode.nvim",
		name = "vscode",
		lazy = false,
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
	base46 = {
		"jayden-chan/base46.nvim",
		name = "base46",
		lazy = false,
		priority = 1000,
		config = function()
			-- Press gf to go the folder
			require("config.plugin-base46").load({
        -- All availables theme at ~/.local/share/nvim/lazy/base46/lua/base46/hl_themes/
        theme = "onedark",
				transparency = false,
			})
			vim.g.blinkcmp_border = "none"
		end,
	},
	vague = {
		"vague-theme/vague.nvim",
		name = "vague",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			-- NOTE: you do not need to call setup if you don't want to.
			require("vague").setup({
				transparent = false, -- don't set background
				-- disable bold/italic globally in `style`
				bold = true,
				italic = true,
				style = {
					-- "none" is the same thing as default. But "italic" and "bold" are also valid options
					boolean = "none",
					number = "none",
					float = "none",
					error = "bold",
					comments = "italic",
					conditionals = "none",
					functions = "none",
					headings = "bold",
					operators = "none",
					strings = "italic",
					variables = "none",

					-- keywords
					keywords = "none",
					keyword_return = "italic",
					keywords_loop = "none",
					keywords_label = "none",
					keywords_exception = "none",

					-- builtin
					builtin_constants = "bold",
					builtin_functions = "none",
					builtin_types = "bold",
					builtin_variables = "none",
				},
				-- plugin styles where applicable
				-- make an issue/pr if you'd like to see more styling options!
				plugins = {
					cmp = {
						match = "bold",
						match_fuzzy = "bold",
					},
					dashboard = {
						footer = "italic",
					},
					lsp = {
						diagnostic_error = "bold",
						diagnostic_hint = "none",
						diagnostic_info = "italic",
						diagnostic_ok = "none",
						diagnostic_warn = "bold",
					},
					neotest = {
						focused = "bold",
						adapter_name = "bold",
					},
					telescope = {
						match = "bold",
					},
				},
			})
			vim.cmd("colorscheme vague")
		end,
	},
	cursor_dark = {
		"ydkulks/cursor-dark.nvim",
		name = "cursor-dark",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("cursor-dark-midnight")
			require("cursor-dark").setup({
				-- For theme
				style = "dark-midnight",
				-- For a transparent background
				transparent = false,
			})
		end,
	},
}

-- Super clean =))
local cs = require("utility.colorscheme")

-- Recomment lever = index
cs.list = {
	c.nightfox,         -- Recomment!
	c.catppuccin,       -- Recomment!
	c.vscode,           -- Recomment!
	c.vague,            -- Recomment! Like vscode
	c.gruvbox,          -- Recomment!
	c.gruvbox_material, -- Recomment!
	c.kanagawa,         -- Recomment!
	c.kanagawa_paper,   -- Recomment!
	c.base46,           -- Recomment! Like NvChad colorscheme
	c.edge,             -- Recomment! Better than onedark
	c.everforest,       -- Recomment!
	c.cyberdream,       -- Recomment!
	c.nord,             -- Hmmmmm!
	c.tokyonight,       -- Hmmmmm!
	c.onedark,          -- Hmmmmm!
	c.cursor_dark,      -- Hmmmmm!
}

-- NOTE: Goto ~/.config/nvim/lua/config/lazy.lua to more infos
return cs.install_(c.base46)
