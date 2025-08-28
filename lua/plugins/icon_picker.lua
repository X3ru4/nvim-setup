return {
	"ziontee113/icon-picker.nvim",
	event = "VeryLazy",
	config = function()
		require("icon-picker").setup({ disable_legacy_commands = true })
		vim.keymap.set("n", "<Leader>fi", "<cmd>IconPickerNormal<cr>", {
			noremap = true,
			silent = true,
			desc = "Pick icon",
		})
		vim.keymap.set("n", "<Leader>fy", "<cmd>IconPickerYank<cr>", {
			noremap = true,
			silent = true,
			desc = "Yank icon",
		})
		vim.keymap.set("i", "<C-a>", "<cmd>IconPickerInsert<cr>", {
			noremap = true,
			silent = true,
		})
	end,
	keys = {
		{ "<leader>fi", "<cmd>" },
	},
}
