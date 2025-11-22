return {

	{
		"nanozuki/tabby.nvim",
		enabled = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.o.showtabline = 2
			local theme = {
				fill = "TabLineFill",
				-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
				head = "TabLine",
				current_tab = "TabLineSel",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}
			require("tabby").setup({
				line = function(line)
					return {
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current_tab or theme.tab
							return {
								line.sep("", hl, theme.fill),
								tab.is_current() and "" or "󰆣",
								tab.number(),
								tab.name(),
								tab.close_btn(""),
								line.sep("", hl, theme.fill),
								hl = hl,
								margin = " ",
							}
						end),
						line.spacer(),
						line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
							return {
								line.sep("", theme.win, theme.fill),
								win.is_current() and "" or "",
								win.buf_name(),
								line.sep("", theme.win, theme.fill),
								hl = theme.win,
								margin = " ",
							}
						end),
						hl = theme.fill,
					}
				end,
				-- option = {}, -- setup modules' option,
			})
		end,
	},

	{
		"akinsho/bufferline.nvim",
		enabled = false,
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = false,
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "none",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "● ",
				close_icon = " ",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				truncate_names = true, -- whether or not tab names should be truncated
				tab_size = 10,
				diagnostics = false,
				separator_style = "slant",
			},
		},
	},

	{
		"romgrk/barbar.nvim",
		enabled = false,
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
}
