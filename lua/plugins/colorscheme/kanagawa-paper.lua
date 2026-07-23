return {
	"thesimonho/kanagawa-paper.nvim",
	name = "kanagawa-paper",
	config = function()
		require("kanagawa-paper").setup({
			transparent = false,
			dim_inactive = false,
			cache = true,

			styles = {
				comment = { italic = true },
				functions = { italic = false, bold = true },
				keyword = { italic = true, bold = false },
				statement = { italic = true, bold = false },
			},
		})

    vim.o.background = "light"
		vim.cmd.colorscheme("kanagawa-paper")
	end,
}
