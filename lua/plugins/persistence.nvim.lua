return {
	"folke/persistence.nvim",
	enabled = true,
	opts = {},
	keys = {
		{
			"<leader>gs",
			function()
				require("persistence").load()
			end,
			desc = "Restore Session",
		},
		{
			"<leader>gS",
			function()
				require("persistence").select()
			end,
			desc = "Select Session",
		},
		{
			"<leader>gl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore Last Session",
		},
		{
			"<leader>gd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't Save Current Session",
		},
	},
}
