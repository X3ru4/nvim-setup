return {
	{
		"folke/todo-comments.nvim",
    enabled = false,
		event = "VeryLazy",
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
			},
		},
		opts = {},
	},
}
