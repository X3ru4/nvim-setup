return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ui = { border = "rounded" },
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "BufReadPre",
		opts = {},
	},
}
