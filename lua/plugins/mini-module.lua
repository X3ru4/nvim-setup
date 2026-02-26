return {

	{
		"nvim-mini/mini.icons",
		event = "VeryLazy",
		opts = {},
	},

	{
		"nvim-mini/mini.align",
		version = false,
		event = "VeryLazy",
		-- Module mappings. Use `''` (empty string) to disable one.
		opts = {
			mappings = {
				start = "ga",
				start_with_preview = "gA",
			},

			-- Modifiers changing alignment steps and/or options

			-- Default options controlling alignment process
			options = {
				split_pattern = "",
				justify_side = "left",
				merge_delimiter = "",
			},

			-- Default steps performing alignment (if `nil`, default is used)
			steps = {
				pre_split = {},
				split = nil,
				pre_justify = {},
				justify = nil,
				pre_merge = {},
				merge = nil,
			},

			-- Whether to disable showing non-error feedback
			-- This also affects (purely informational) helper messages shown after
			-- idle time if user input is required.
			silent = true,
		},
	},

	{
		"nvim-mini/mini.cursorword",
		enabled = false,
		event = "BufReadPre",
		opts = {
			delay = 100,
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"fzf",
					"help",
					"lazy",
					"mason",
					-- "oil",
					-- "oil_preview",
					"dropbar_menu",
				},
				callback = function()
					vim.b.minicursorword_disable = true
				end,
			})
		end,
	},

	{
		"nvim-mini/mini.notify",
		enabled = true,
		event = "VimEnter",
		version = false,
		keys = {
			{
				"<C-h>",
				function()
					require("mini.notify").show_history()
				end,
			},
		},
		opts = {
			-- Content management
			content = {
				format = function(notify)
					local icons = require("config.icons").vim_log_level
					return string.format("%s │ %s.", icons[notify.level], notify.msg)
				end,
				sort = function(notify_arr)
					table.sort(notify_arr, function(a, b)
						return a.ts_update > b.ts_update
					end)
					return notify_arr
				end,
			},

			-- Notifications about LSP progress
			lsp_progress = { enable = false },

			-- Window options
			window = {
				-- Floating window config
				---@type vim.api.keyset.win_config
				config = {
					border = "rounded",
					anchor = "NW",
					title = "󰂞 Notifications",
					title_pos = "center",
					footer = "-+-",
					footer_pos = "center",
				},

				-- Maximum window width as share (between 0 and 1) of available columns
				max_width_share = 0.382,
				winblend = 0,
			},
		},
	},

	{
		"nvim-mini/mini.hipatterns",
		enabled = true,
		event = "VeryLazy",
		version = false,
		opts = {
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				author = { pattern = "%f[%w]()X3ru4()%f[%W]", group = "MiniHipatternsHack" },
				bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "MiniHipatternsFixme" },

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
		opts = {
			view = {
				-- Visualization style. Possible values are 'sign' and 'number'.
				---@type "sign"|"number"
				style = "number",

				-- Signs used for hunks with 'sign' view
				signs = { add = "", change = "", delete = "" },
				-- Priority of used visualization extmarks
				priority = 199,
			},
			source = nil,

			-- Delays (in ms) defining asynchronous processes
			delay = {
				-- How much to wait before update following every text change
				text_change = 200,
			},

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Apply hunks inside a visual/operator region
				apply = "gh",

				-- Reset hunks inside a visual/operator region
				reset = "gH",

				-- Hunk range textobject to be used inside operator
				-- Works also in Visual mode if mapping differs from apply and reset
				textobject = "gh",

				-- Go to hunk range in corresponding direction
				goto_first = "[H",
				goto_prev = "[h",
				goto_next = "]h",
				goto_last = "]H",
			},

			-- Various options
			options = {
				-- Diff algorithm. See `:h vim.diff()`.
				algorithm = "histogram",

				-- Whether to use "indent heuristic". See `:h vim.diff()`.
				indent_heuristic = true,

				-- The amount of second-stage diff to align lines
				linematch = 60,

				-- Whether to wrap around edges during hunk navigation
				wrap_goto = false,
			},
		},
	},

	{
		"nvim-mini/mini.tabline",
		enabled = true,
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			always_show = false,
			tabpage_section = "left",

			format = function(bufnr, label)
				local current_buf = vim.api.nvim_get_current_buf() == bufnr
				local modify_icon = require("config.icons").icons.modified
				local file_icon = require("mini.icons").get("file", label)
				local suffix = vim.bo[bufnr].modified and " " .. modify_icon .. "" or ""
				local strings = {
					current_buf and "▏" or " ",
					string.format(" %s %s%s%s", file_icon, label, suffix, suffix ~= "" and "" or " "),
					current_buf and "▕" or " ",
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
				symbol = "▏",
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
		-- Using heirline.nvim
		"nvim-mini/mini.statusline",
		enabled = false,
		event = "VimEnter",
		version = true,
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
							local icons, hl
							icons, hl = require("mini.icons").get("file", vim.fn.expand("%:t"))
							local modify_icon = function(filetype, icon)
								if vim.bo.filetype == filetype then
									icons = icon
								end
							end

							modify_icon("", "X3ru4")
							modify_icon("alpha", "α")
							modify_icon("oil", "󰏇")
							modify_icon("lazy", "💤")
							modify_icon("mason", " ")
							modify_icon("checkhealth", "󰩂 ")

							return table.concat({
								"%#",
								hl,
								"#",
								init,
								icons,
								" ",
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
											ERROR = table.concat({
												"%#DiagnosticError#",
												require("config.icons").diagnostic.errr,
												" ",
												"%#StatusLine# ",
											}),
											WARN = table.concat({
												"%#DiagnosticWarn#",
												require("config.icons").diagnostic.warn,
												" ",
												"%#StatusLine# ",
											}),
											INFO = table.concat({
												"%#DiagnosticInfo#",
												require("config.icons").diagnostic.info,
												" ",
												"%#StatusLine# ",
											}),
											HINT = table.concat({
												"%#DiagnosticHint#",
												require("config.icons").diagnostic.hint,
												" ",
												"%#StatusLine# ",
											}),
										},
									}):gsub("%s+(%d+)", "%1"),
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
