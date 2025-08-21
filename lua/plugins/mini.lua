return {
	{ "echasnovski/mini.surround", lazy = true, event = "BufReadPost", version = "*", opts = {} },
	{ "echasnovski/mini.align", lazy = true, event = "BufReadPost", version = "*", opts = {} },
	{ "echasnovski/mini.move", lazy = true, event = "BufReadPost", version = "*", opts = {} },
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		version = "*",
		opts = {
			modes = { insert = true, command = true, terminal = false },
		},
	},
	{
		"echasnovski/mini.ai",
		event = "BufReadPost",
		version = "*",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(),
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
				},
			}
		end,
	},
}
