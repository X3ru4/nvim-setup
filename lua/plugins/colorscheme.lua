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
			use("tokyonight-moon")
		end,
	},
	onedark = {
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "dark",
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
				flavour = "frappe",
				transparent_background = false, -- disables setting the background color.
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
	norden = {
		"fcancelinha/nordern.nvim",
		branch = "master",
		priority = 1000,
    config = function ()
      use("nordern")
    end
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
}

return colorschemes.norden
