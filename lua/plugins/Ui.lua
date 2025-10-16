return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			select = {
				backend = "fzf_lua",
			},
		},
	},

	-- TabLine
	{
		enabled = false,
		"romgrk/barbar.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.barbar_auto_setup = true
		end,
		opts = {
			focus_on_close = "right",
			clickable = false,
			auto_hide = true,
			icons = {
				button = "",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},
				separator = { left = "", right = "" },
				separator_at_end = true,
				pinned = { button = require("config.icons").icons.pin, filename = false },
				modified = { button = require("config.icons").icons.modified },
			},
			maximum_length = 20,
		},
		version = "^1.0.0",
		keys = {
			{ "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
			{ "<S-l>", "<cmd>BufferNext<cr>", desc = "Next buffer" },
			{ "<A-1>", "<Cmd>BufferGoto 1<CR>" },
			{ "<A-2>", "<Cmd>BufferGoto 2<CR>" },
			{ "<A-3>", "<Cmd>BufferGoto 3<CR>" },
			{ "<A-4>", "<Cmd>BufferGoto 4<CR>" },
			{ "<A-5>", "<Cmd>BufferGoto 5<CR>" },
			{ "<A-6>", "<Cmd>BufferGoto 6<CR>" },
			{ "<A-7>", "<Cmd>BufferGoto 7<CR>" },
			{ "<A-8>", "<Cmd>BufferGoto 8<CR>" },
			{ "<A-9>", "<Cmd>BufferGoto 9<CR>" },
			{ "<A-0>", "<Cmd>BufferLast<CR>" },
			-- Close buffer
			{ "<leader>bd", "<Cmd>BufferClose<CR>" },

			-- Move last
			{ "<leader>bb", "<Cmd>buffer #<CR>" },

			-- Magic buffer-picking mode
			{ "<C-p>", "<Cmd>BufferPick<CR>" },

			-- Sort automatically by...
			{ "<Space>bn", "<Cmd>BufferOrderByName<CR>" },
			{ "<Space>bD", "<Cmd>BufferOrderByDirectory<CR>" },
			{ "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>" },
			{ "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>" },
		},
	},

	{
		enabled = false,
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			local diagnostic = require("config.icons").diagnostic
			local diag_ = {
				"diagnostics",
				update_in_insert = false,
				symbols = {
					error = diagnostic.errr .. " ",
					warn = diagnostic.warn .. " ",
					info = diagnostic.info .. " ",
					hint = diagnostic.hint .. " ",
				},
			}
			return {
				options = {
					theme = "auto",
					disabled_filetypes = {
						statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
					},
					component_separators = {
						left = "",
						right = "|",
					},
					section_separators = {
						left = "",
						right = "",
					},
					always_show_tabline = true,
					refresh = {
						tabline = nil,
						winbar = nil,
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = { left = "", right = "" },
							padding = { left = 0, right = 0 },
							fmt = function(str)
								return str:sub(1, 3)
							end,
						},
					},
					lualine_b = {
						{
							"filetype",
							padding = { left = 1, right = 0 },
							fmt = function()
								return ""
							end,
							icon_only = false,
						},
						{
							"filename",
							padding = { left = 1, right = 1 },
							shorting_target = 10,
							symbols = {
								modified = require("config.icons").icons.modified,
								readonly = "",
								unnamed = "[No Name]",
								newfile = "[New]",
							},
						},
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {
						diag_,
					},
					lualine_z = {
						{
							"location",
							padding = { left = 0, right = 0 },
							separator = { left = "", right = "" },
						},
					},
				},
				inactive_sections = {},
				tabline = {
					lualine_b = {
						{
							"buffers",
							padding = { left = 0, right = 0 },
							separator = { left = "", right = "" },
							max_length = vim.opt.columns:get(),
							show_filename_only = true,
							hide_filename_extension = true,
							mode = 0,
							fmt = function(str)
								return "" .. str
							end,
							use_mode_colors = true,
							symbols = {
								modified = " ●", -- Text to show when the buffer is modified
								alternate_file = "#", -- Text to show to identify the alternate file
								directory = "", -- Text to show when the buffer is a directory
							},
						},
					},
				},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}
		end,
	},

	-- WinBar
	{
		"Bekaboo/dropbar.nvim",
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
			menu = {
				win_configs = {
					border = "rounded",
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
	},

	-- Other
	{
		enabled = false,
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		config = function()
			require("fidget").setup({})
			vim.notify = require("fidget").notify
		end,
	},

	{
		enabled = false,
		"NStefan002/screenkey.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {},
	},

	{
		enabled =false,
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {
			cursor_color = "#d8dee9",
			smear_insert_mode = true,
			stiffness = 0.5,
			trailing_stiffness = 0.5,
			matrix_pixel_threshold = 0.5,
		},
	},
}
