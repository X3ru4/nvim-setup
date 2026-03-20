return {

	{
		-- WARNING: Do not disable this plugin!
		"nvim-mini/mini.icons",
		event = "VeryLazy",
		opts = {
			style = "glyph",
			-- Customize per category. See `:h MiniIcons.config` for details.
			default = {},
			directory = {
				Download = { glyph = "󰉍", hl = "MiniIconsOrange" },
				Movies = { glyph = "󰎁", hl = "MiniIconsOrange" },
			},
			file = {
        bash = { glyph = "", hl = "MiniIconsOrange" }
      },
			filetype = {},
			extension = {},
			lsp = {},
			os = {},
		},
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
					return string.format("%s │ %s", icons[notify.level], notify.msg)
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

				author = { pattern = "%f[%w]()X3ru4()%f[%W]", group = "MiniHipatternsFixme" },
				warning = { pattern = "%f[%w]()WARNING()%f[%W]", group = "MiniHipatternsHack" },
				warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },
				bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "MiniHipatternsFixme" },
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
			{ "Sa", mode = { "n", "x", "v" } },
      { "Sd", mode = { "n", "x", "v" } },
      { "Sr", mode = { "n", "x", "v" } },
      { "Sf", mode = { "n", "x", "v" } },
      { "SF", mode = { "n", "x", "v" } },
		},
		opts = {
			mappings = {
				add = "Sa",
				delete = "Sd",
				find = "Sf",
				find_left = "SF",
				highlight = "Sh",
				replace = "Sr",
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
