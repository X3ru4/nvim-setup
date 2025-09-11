return {
	{
		-- enabled = false,
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").load()
		end,
	},
	{
		enabled = false,
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "darker",
				ending_tildes = false,
			})
			require("onedark").load()
		end,
	},
	{
		enabled = false,
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
