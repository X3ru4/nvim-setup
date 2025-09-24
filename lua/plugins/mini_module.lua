local plugins = {}

local function module(name, opts)
	table.insert(plugins, vim.tbl_deep_extend("force", { "nvim-mini/mini." .. name }, opts))
end

module("diff", {
	event = "BufReadPre",
	version = false,
	opts = {},
})
module("tabline", {
	event = "VeryLazy",
	version = false,
	opts = {
		always_show = false,
		tabpage_section = "left",
		format = function(buf_id, label)
			local suffix = vim.bo[buf_id].modified and "󰐕 " or ""
			return MiniTabline.default_format(buf_id, label) .. suffix
		end,
	},
})
module("indentscope", {
	event = "BufReadPre",
	version = false,
	opts = {
		draw = {
			delay = 50,
			priority = 2,
		},
		mappings = {
			object_scope = "ii",
			object_scope_with_border = "ai",
			goto_top = "[i",
			goto_bottom = "]i",
		},
		options = {
			border = "both",
			indent_at_cursor = true,
			n_lines = 10000,
			try_as_border = false,
		},
		symbol = "│",
	},
})
module("surround", {
	event = "VeryLazy",
	version = false,
	opts = {},
})
module("align", {
	event = "VeryLazy",
	version = false,
	opts = {},
})
module("move", {
	event = "VeryLazy",
	version = false,
	opts = {},
})
module("cursorword", {
	event = "VeryLazy",
	version = false,
	opts = {},
})
module("statusline", {
	event = "VeryLazy",
	version = false,
	config = function()
		require("mini.statusline").setup({
			content = {
				active = function()
					local sl = require("mini.statusline")
					local mode, mode_hl = sl.section_mode({ trunc_width = 120 })

					local mmode = function()
						local modes = {
							n = "Normal",
							i = "Insert",
							v = "Visual",
							V = "Visual Line",
							["\22"] = "Visual Block", -- CTRL+V
							c = "Command",
							R = "Replace",
							t = "Terminal",
							s = "Select",
							S = "Select Line",
							["\19"] = "Select Block", -- CTRL+S
						}

						local current_mode = vim.api.nvim_get_mode().mode
						return modes[current_mode] or "Normal"
					end

					local function modified()
						return vim.bo.modified and require("config.icons").icons.modified or ""
					end

					return sl.combine_groups({
						{
							hl = mode_hl,
							strings = { mmode() },
						},
						"%<",
						{
							hl = "PmenuExtra",
							strings = {
								"%t" .. modified(),
							},
						},
						"%=",
						{
							hl = "PmenuMatch",
							strings = {
								sl.section_diagnostics({
									signs = {
										ERROR = require("config/icons").diagnostic.errr .. " ",
										WARN = require("config/icons").diagnostic.warn .. " ",
										INFO = require("config/icons").diagnostic.info .. " ",
										HINT = require("config/icons").diagnostic.hint .. " ",
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
})
module("ai", {
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
})

return plugins
