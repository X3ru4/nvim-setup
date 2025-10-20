return {

	{
		"nvim-tree/nvim-web-devicons",
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
			{ "<Leader>fiy", "<cmd>IconPickerYank<cr>", noremap = true, silent = true, desc = "Yank icon" },
			{ mode = "i", "<C-z>", "<cmd>IconPickerInsert<cr>", noremap = true, silent = true },
		},
	},
}
