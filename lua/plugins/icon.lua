return {

	{
		"nvim-tree/nvim-web-devicons",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},

	{
		"ziontee113/icon-picker.nvim",
		enabled = false,
		opts = {
			disable_legacy_commands = true,
		},
		keys = {
			{ "<Leader>fi", "<cmd>IconPickerNormal<cr>", noremap = true, silent = true, desc = "Pick icon" },
			{ "<Leader>fy", "<cmd>IconPickerYank<cr>", noremap = true, silent = true, desc = "Yank icon" },
		},
	},

	{
		"2kabhishek/nerdy.nvim",
		cmd = "Nerdy",
		opts = {
			max_recents = 10, -- Configure recent icons limit
			copy_to_clipboard = true, -- Copy glyph to clipboard instead of inserting
			copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
		},
		keys = {
			{ "<leader>fn", "<cmd>Nerdy list<CR>", desc = "Browse nerd icons" },
			{ "<leader>fN", "<cmd>Nerdy recents<CR>", desc = "Browse recent nerd icons" },
		},
	},
}
