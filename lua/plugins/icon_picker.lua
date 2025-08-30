return {
	"ziontee113/icon-picker.nvim",
	config = function()
		require("icon-picker").setup({ disable_legacy_commands = true })
	end,
	keys = {
		{ "<Leader>fi", "<cmd>IconPickerNormal<cr>", noremap = true, silent = true, desc = "Pick icon" },
		{ "<Leader>fy", "<cmd>IconPickerYank<cr>", noremap = true, silent = true, desc = "Yank icon" },
		{ mode = "i", "<C-z>", "<cmd>IconPickerInsert<cr>", noremap = true, silent = true },
	},
}
