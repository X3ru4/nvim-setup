local plugins = {}

local function module(name, opts)
	table.insert(plugins, vim.tbl_deep_extend("force", { "nvim-mini/mini." .. name }, opts))
end

-- module("icons", {
--   event = "VeryLazy",
-- 	version = false,
--   opts = {}
-- })
module("diff", {
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = {},
})
module("tabline", {
	event = { "BufReadPre", "BufNewFile" },
	enabled = true,
	version = false,
	opts = {
		always_show = false,
		tabpage_section = "left",
		format = function(buf_id, label)
			local suffix = vim.bo[buf_id].modified and "+ " or ""
			local current_buf = vim.api.nvim_get_current_buf() == buf_id
			local strings = {
        current_buf and "|" or "",
				-- vim.g.colors_name == "onedark" and (current_buf and "⌞" or "⌜") or "",
				require("mini.tabline").default_format(buf_id, label),
				suffix,
				-- vim.g.colors_name == "onedark" and (current_buf and "⌝" or "⌟") or "",
				"",
			}
			return table.concat(strings)
		end,
	},
})
module("indentscope", {
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = function()
		return {
			draw = {
				delay = 100,
				animation = function(s, n)
					return 15
				end,
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
				n_lines = 100,
				try_as_border = true,
			},
			symbol = "│",
		}
	end,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"fzf",
				"help",
				"lazy",
				"mason",
				"oil",
        "oil_preview",
				"dropbar_menu",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
})
module("surround", {
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = {},
})
module("align", {
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = {},
})
module("move", {
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = {},
})
module("cursorword", {
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = {
		delay = 30,
	},
})
module("statusline", {
	enabled = true,
	event = "VeryLazy",
	version = false,
	config = function()
		require("mini.statusline").setup({
			content = {
				active = function()
					local sl = require("mini.statusline")
					local _, mode_hl = sl.section_mode({ trunc_width = 120 })

					local mode_str = function()
						local modes = {
							n = "Normal",
							i = "Insert",
							v = "Visual",
							V = "V-Line",
							["\22"] = "V-Block", -- CTRL+V
							c = "Command",
							R = "Replace",
							t = "Terminal",
							s = "Select",
							S = "S-Line",
							["\19"] = "S-Block", -- CTRL+S
						}

						local current_mode = vim.api.nvim_get_mode().mode
						return modes[current_mode] or "Normal"
					end

					local function file_icon(init)
						local filetype = vim.fn.expand("%:e")
						local icons = require("nvim-web-devicons").get_icon(filetype, nil, { default = true })
						filetype = filetype:sub(1, 1):upper() .. filetype:sub(2)
						local strings = {
							"%#DevIcon",
							filetype,
							"#",
							init,
							icons,
							"%#Nop#",
						}
						return table.concat(strings)
					end

					return sl.combine_groups({
						{
							hl = mode_hl,
							strings = { mode_str() },
						},
						"%<",
						{
							hl = "Nop",
							strings = {
								table.concat({
									file_icon(vim.bo.filetype .. " "),
									--          "tabs:",
									-- vim.bo.tabstop,
									(vim.bo.modified and "Modified" or ""),
								}, " "),
							},
						},
						"%=",
						{
							hl = "Nop",
							strings = {
								sl.section_diagnostics({
                  icon = "",
									signs = {
										ERROR = "%#DiagnosticError#"
											.. require("config.icons").diagnostic.errr
											.. "%#Nop# ",
										WARN = "%#DiagnosticWarn#"
											.. require("config.icons").diagnostic.warn
											.. "%#Nop# ",
										INFO = "%#DiagnosticInfo#"
											.. require("config.icons").diagnostic.info
											.. "%#Nop# ",
										HINT = "%#DiagnosticHint#"
											.. require("config.icons").diagnostic.hint
											.. "%#Nop# ",
									},
								}),
							},
						},
					})
				end,
			},
		})
	end,
})
module("ai", {
	event = { "BufReadPre", "BufNewFile" },
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
