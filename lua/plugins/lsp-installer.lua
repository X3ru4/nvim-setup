return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				height = 0.85,
				border = "solid",
				icons = {
					package_installed = "󰄬 ",
					package_pending = "󰔟 ",
					package_uninstalled = "󰜺 ",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			automatic_enable = false,
		},
	},
}
