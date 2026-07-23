return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			custom_highlights = function(colors)
				return {
					SnacksIndentScope = { fg = colors.lavender },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin-nvim")
	end,
}
