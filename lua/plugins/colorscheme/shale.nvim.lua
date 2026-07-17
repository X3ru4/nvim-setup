return {
	"smit4k/shale.nvim",
	name = "shale",
	config = function()
		require("shale").setup({
			italic_comments = true,
			italic_keywords = true,
			transparent = false,
      require("plugins.colorscheme")
		})

		vim.cmd.colorscheme("shale")
	end,
}
