return {
	"stevearc/dressing.nvim",
	enabled = true,
	event = "VeryLazy",
	opts = {
		input = {
			override = function(conf)
				conf.col = -1
				conf.row = 0
				return conf
			end,
			border = "rounded",
		},
		select = {
			backend = "fzf_lua",
		},
	},
}
