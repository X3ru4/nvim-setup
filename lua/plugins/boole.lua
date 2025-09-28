return {
	"nat-418/boole.nvim",
	event = "BufReadPre",
	config = function()
		require("boole").setup({
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
			additions = {
				-- { "Foo", "Bar" },
				-- { "tic", "tac", "toe" },
			},
			allow_caps_additions = {
				{ "enable", "enable" },
				{ "disable", "disable" },
				{ "true", "false" },
			},
		})
	end,
}
