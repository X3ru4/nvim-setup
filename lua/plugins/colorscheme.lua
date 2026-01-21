-- If you want add more colorschemes you must add the name to the @alias ColorSchemeList
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
	gruvbox = {
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({})
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
			vim.cmd.colorscheme("sonokai")
		end,
	},
	nightfox = {
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
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
	{
		{
			{
				{
					{
						{
							{
								{},
							},
						},
					},
				},
			},
		},
	},
	vscode = {
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").load("dark")
			local colors = require("vscode.colors").get_colors()
			local hl = require("util.hl_api")

			-- BlinkPair
			hl.set("BlinkPairsUnmatched", {
				fg = colors.vscRed,
				strikethrough = true,
			})
			hl.set("BlinkPairsBlue", {
				link = "RainbowDelimiterBlue",
			})
			hl.set("BlinkPairsOrange", {
				link = "RainbowDelimiterOrange",
			})
			hl.set("BlinkPairsPurple", {
				link = "RainbowDelimiterPurple",
			})

			-- BlinkIndent
			hl.set("BlinkIndentRed", {
				link = "RainbowDelimiterRed",
			})
			hl.set("BlinkIndentCyan", {
				link = "RainbowDelimiterCyan",
			})
			hl.set("BlinkIndentBlue", {
				link = "RainbowDelimiterBlue",
			})
			hl.set("BlinkIndentGreen", {
				link = "RainbowDelimiterGreen",
			})
			hl.set("BlinkIndentYellow", {
				link = "RainbowDelimiterYellow",
			})
			hl.set("BlinkIndentViolet", {
				link = "RainbowDelimiterViolet",
			})
			hl.set("BlinkIndentOrange", {
				link = "RainbowDelimiterOrange",
			})
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

			vim.cmd("colorscheme github_dark")
		end,
	},
}

---@alias ColorSchemeList
---|"tokyonight"
---|"onedark"
---|"catppuccin"
---|"nord"
---|"nordic"
---|"nordern"
---|"rose_pine"
---|"gruvbox"
---|"kanagawa"
---|"kanagawa_paper"
---|"sonokai"
---|"nightfox"
---|"material"
---|"cyberdream"
---|"vscode"
---|"github"

---@param name string|"all"|ColorSchemeList[]
---@param setup ColorSchemeList|nil
---@return table
local function install(name, setup)
	local t = {}

	local function push(arg, opts)
		if arg ~= setup then
			local item = {
				opts[1],
				name = opts.name or nil,
				dependencies = opts.dependencies or nil,
			}
			table.insert(t, item)
		else
			table.insert(t, opts)
		end
	end

	if type(name) == "table" then
		for _, cn in ipairs(name) do
			local opts = colorschemes[cn]
			if opts then
				push(cn, opts)
			end
		end
	elseif type(name) == "string" then
		if string.lower(name) == "all" then
			for cn, opts in pairs(colorschemes) do
				push(cn, opts)
			end
		else
			push(name, colorschemes[name])
		end
	end

	return t
end

return install({
	"tokyonight", -- Unsupport statusline
	"catppuccin", -- Recomment!
	"kanagawa",   -- Recomment!
	"onedark",
	"gruvbox",    -- Recomment!
	"kanagawa_paper",
	"vscode",     -- Recomment!
  "github",
}, "vscode")
