return {

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			win = {
				no_overlap = true,
				width = 20,
				height = { min = 4, max = 10 },
				-- col = 0,
				-- row = 0,
				border = "rounded",
				padding = { 1, 1 },
				title = true,
				title_pos = "left",
				zindex = 1000,
				bo = {},
				wo = {
					-- winblend = 20,
				},
			},
		},
		keys = {
			{
				"<leader><leader>",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
