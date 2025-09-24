return {
	"Bekaboo/dropbar.nvim",
	event = "LspAttach",
	opts = {
		icons = {
			ui = {
				bar = {
					separator = "  ",
					extends = "…",
				},
			},
		},
		sources = {
			path = {
				max_depth = 1,
			},
		},
	},
	keys = function()
		local api = require("dropbar.api")
		return {
			{ "<Leader>;", api.pick, desc = "Pick symbols in winbar" },
			{ "[;", api.goto_context_start, desc = "Go to start of current context" },
			{ "];", api.select_next_context, desc = "Select next context" },
		}
	end,
}
