return {

	{
		"nvim-tree/nvim-web-devicons",
    enabled = false,
		event = "VeryLazy",
		opts = {},
	},

	{
		"ziontee113/icon-picker.nvim",
		opts = {
			disable_legacy_commands = true,
		},
		keys = {
			{ "<Leader>fi", "<cmd>IconPickerNormal<cr>", noremap = true, silent = true, desc = "Pick icon" },
			{ "<Leader>fy", "<cmd>IconPickerYank<cr>", noremap = true, silent = true, desc = "Yank icon" },
		},
	},
}
