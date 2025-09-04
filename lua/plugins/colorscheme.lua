return {
	"folke/tokyonight.nvim",
	event = "VimEnter",
	priority = 1000,
	config = function()
		require("tokyonight").load()
	end,
}
