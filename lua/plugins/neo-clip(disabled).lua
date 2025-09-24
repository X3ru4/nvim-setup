return {
	enabled = false,
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
		{ "ibhagwan/fzf-lua" },
	},
	config = function()
		require("neoclip").setup({
			history = 20,
			enable_persistent_history = true,
			length_limit = 1048576,
			keys = {
				fzf = {
					select = "default",
					paste = "space",
					paste_behind = "ctrl-k",
					custom = {},
				},
			},
		})
	end,
	keys = {
		{
			"<leader>p",
			function()
				require("neoclip.fzf")("0")
			end,
			desc = "Yank history",
		},
	},
}
