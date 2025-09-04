return {

	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		version = false,
		opts = {},
	},

	{
		"echasnovski/mini.align",
		event = "VeryLazy",
		version = false,
		opts = {},
	},

	{
		"echasnovski/mini.move",
		event = "VeryLazy",
		version = false,
		opts = {},
	},

	{
		"echasnovski/mini.cursorword",
		event = "VeryLazy",
		version = false,
		opts = {
			delay = 50,
		},
	},

	{
		"nvim-mini/mini.statusline",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.statusline").setup({
				content = {
					active = function()
						local sl = require("mini.statusline")
						local mode, mode_hl = sl.section_mode({ trunc_width = 120 })

						return sl.combine_groups({
							{
								hl = mode_hl,
								strings = { mode },
							},
							"%<",
							{
								hl = "MiniStatuslineDevinfo",
								strings = {
									sl.section_fileinfo({ trunc_width = 100 }),
									" 𝙓𝝐𝖗𝖚𝜶",
									"%m%r",
								},
							},
							"%=",
							{
								hl = "MiniStatuslineDevinfo",
								strings = {
									sl.section_diagnostics({
										signs = {
											ERROR = require("../config/icons").diagnostic.errr .. " ",
											WARN = require("../config/icons").diagnostic.warn .. " ",
											INFO = require("../config/icons").diagnostic.info .. " ",
											HINT = require("../config/icons").diagnostic.hint .. " ",
										},
									}),
								},
							},
							{
								hl = mode_hl,
								strings = { sl.section_location({ trunc_width = 100 }) },
							},
						})
					end,
				},
			})
		end,
	},

	{
		"echasnovski/mini.ai",
		event = "BufReadPost",
		version = false,
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
