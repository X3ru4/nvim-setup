return {

	{
		"nvim-mini/mini.notify",
		enabled = false,
		event = "VeryLazy",
		version = false,
		-- No need to copy this inside `setup()`. Will be used automatically.
		opts = {
			-- Content management
			content = {
				-- Function which formats the notification message
				-- By default prepends message with notification time
				format = function(notif)
					if notif.data.source == "lsp_progress" then
						return notif.msg
					end
					return require("mini.notify").default_format(notif)
				end,

				-- Function which orders notification array from most to least important
				-- By default orders first by level and then by update timestamp
				sort = nil,
			},

			-- Notifications about LSP progress
			lsp_progress = {
				-- Whether to enable showing
				enable = true,
				-- Notification level
				level = "INFO",

				-- Duration (in ms) of how long last message should be shown
				duration_last = 1000,
			},

			-- Window options
			window = {
				-- Floating window config
				config = {
					border = "rounded",
					anchor = "SE",
					row = 99,
				},

				-- Maximum window width as share (between 0 and 1) of available columns
				max_width_share = 0.382,
				winblend = 20,
			},
		},
	},

	{
		"nvim-mini/mini.hipatterns",
		enabled = false,
		event = "VeryLazy",
		version = false,
		opts = {
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
			},
		},
	},

	{
		"nvim-mini/mini.sessions",
		-- Used folke/persistence.nvim
		enabled = false,
		version = false,
		config = function()
			require("mini.sessions").setup({
				silent = true,
			})
			vim.g.save_session = true
			vim.api.nvim_create_autocmd("VimLeave", {
				callback = function()
					if vim.g.save_session then
						require("mini.sessions").write(require("mini.sessions").get_latest())
					end
				end,
			})
		end,
		keys = function()
			local lastest = require("mini.sessions").get_latest()
			local MiniSessions = require("mini.sessions")
			return {
				{
					"<leader>qs",
					function()
						MiniSessions.read(lastest)
					end,
					desc = "Restore Session",
				},
				{
					"<leader>qw",
					function()
						vim.ui.input({ prompt = "Name" }, function(input)
							if input then
								MiniSessions.write(input)
							end
						end)
					end,
					desc = "Write new session",
				},
				{
					"<leader>qr",
					function()
						MiniSessions.select()
					end,
					desc = "Read Sessions",
				},
				{
					"<leader>qd",
					function()
						MiniSessions.select("delete", {
							force = true,
						})
					end,
					desc = "Delete Sessions",
				},
				{
					"<leader>qt",
					function()
						vim.g.save_session = not vim.g.save_session
						print(vim.g.save_session)
					end,
					desc = "Don't Save Session",
				},
			}
		end,
	},

	{
		"nvim-mini/mini.clue",
		event = "VeryLazy",
		version = false,
		config = function()
			require("mini.clue").setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },

					-- [ and ]
					{ mode = "n", keys = "[" },
					{ mode = "x", keys = "[" },
					{ mode = "n", keys = "]" },
					{ mode = "x", keys = "]" },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					require("mini.clue").gen_clues.builtin_completion(),
					require("mini.clue").gen_clues.g(),
					require("mini.clue").gen_clues.marks(),
					require("mini.clue").gen_clues.registers(),
					require("mini.clue").gen_clues.windows(),
					require("mini.clue").gen_clues.z(),
				},

				-- Clue window settings
				window = {
					-- Floating window config
					config = {
						border = "rounded",
					},

					-- Delay before showing clue window
					delay = 200,

					-- Keys to scroll inside the clue window
					scroll_down = "<C-d>",
					scroll_up = "<C-u>",
				},
			})
		end,
	},

	{
		"nvim-mini/mini.diff",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},

	{
		"nvim-mini/mini.tabline",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			always_show = false,
			tabpage_section = "left",
			format = function(buf_id, label)
				local suffix = vim.bo[buf_id].modified and "+ " or ""
				local current_buf = vim.api.nvim_get_current_buf() == buf_id
				local strings = {
					current_buf and "⟩" or "",
					require("mini.tabline").default_format(buf_id, label),
					suffix,
				}
				return table.concat(strings)
			end,
		},
	},

	{
		"nvim-mini/mini.indentscope",
		enabled = false,
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return {
				draw = {
					delay = 20,
					animation = require("mini.indentscope").gen_animation.none(),
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
	},

	{
		"nvim-mini/mini.surround",
		version = false,
		keys = {
			{ "gsa", mode = { "n", "x", "v" } },
			{ "gsd", mode = { "n", "x", "v" } },
			{ "gsr", mode = { "n", "x", "v" } },
			{ "gsf", mode = { "n", "x", "v" } },
			{ "gsF", mode = { "n", "x", "v" } },
		},
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				suffix_last = "l",
				suffix_next = "n",
			},
			silent = true,
		},
	},

	{
		"nvim-mini/mini.move",
		version = false,
		keys = {
			{ "<A-h>", mode = { "n", "v", "x" } },
			{ "<A-l>", mode = { "n", "v", "x" } },
			{ "<A-j>", mode = { "n", "v", "x" } },
			{ "<A-k>", mode = { "n", "v", "x" } },
		},
		opts = {},
	},

	{
		"nvim-mini/mini.statusline",
		enabled = true,
		version = false,
		event = "VeryLazy",
		-- true if you want lazy load
		lazy = false,
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
								["\22"] = "V-Block",
								c = "Command",
								R = "Replace",
								t = "Terminal",
								s = "Select",
								S = "S-Line",
								["\19"] = "S-Block",
							}
							local current_mode = vim.api.nvim_get_mode().mode
							return modes[current_mode] or "Normal"
						end

						-- local function file_size()
						-- 	local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(0))
						-- 	if ok and stats then
						-- 		local i = 0
						-- 		local sizes = { "B", "KB", "MB", "GB" }
						-- 		while stats.size >= 1024 and i < #sizes - 1 do
						-- 			stats.size = stats.size / 1024
						-- 			i = i + 1
						-- 		end
						-- 		return string.format("%.1f%s", stats.size, sizes[i + 1])
						-- 	else
						-- 		return ""
						-- 	end
						-- end

						local function file_icon(init)
							local filetype = vim.fn.expand("%:e")
							local icons = ""
							if filetype ~= "" then
								icons = require("nvim-web-devicons").get_icon(filetype, nil, { default = true })
							end
							filetype = filetype:sub(1, 1):upper() .. filetype:sub(2)
							return table.concat({
								"%#DevIcon",
								filetype,
								"#",
								init,
								icons,
								"%#StatusLine#",
							})
						end

						return sl.combine_groups({
							{
								hl = mode_hl,
								strings = { mode_str() },
							},
							"%<",
							{
								hl = "StatusLine",
								strings = {
									table.concat({
										file_icon(vim.bo.filetype .. " "),
										(vim.bo.modified and "Modified" or ""),
									}, " "),
								},
							},
							"%=",
							{
								hl = "StatusLine",
								strings = {
									sl.section_diagnostics({
										icon = "",
										signs = {
											ERROR = "%#DiagnosticError#"
												.. require("config.icons").diagnostic.errr
												.. "%#StatusLine# ",
											WARN = "%#DiagnosticWarn#"
												.. require("config.icons").diagnostic.warn
												.. "%#StatusLine# ",
											INFO = "%#DiagnosticInfo#"
												.. require("config.icons").diagnostic.info
												.. "%#StatusLine# ",
											HINT = "%#DiagnosticHint#"
												.. require("config.icons").diagnostic.hint
												.. "%#StatusLine# ",
										},
									}),
								},
							},
							{
								hl = mode_hl,
								strings = {
									"X3ru4",
								},
							},
						})
					end,
				},
			})
		end,
	},

	{
		"nvim-mini/mini.ai",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					i = ai.gen_spec.treesitter({
						a = "@indent.outer",
						i = "@indent.inner",
					}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
					d = { "%f[%d]%d+" },
					e = {
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
				silent = true,
			}
		end,
	},
}
