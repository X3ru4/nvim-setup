return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "darker",
			ending_tildes = true,
			code_style = {
				comments = "italic",
				keywords = "italic",
				functions = "none",
				strings = "none",
				variables = "none",
			},
		})
		vim.cmd("colorscheme onedark")
		-- Color palette used for other plugins
		vim.g.color_palette = require("onedark.palette").darker
	end,
}
