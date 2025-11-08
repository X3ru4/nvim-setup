return {

	{
		enabled = false,
		"gbprod/yanky.nvim",
		opts = {
			ring = { storage = "shada" },
			picker = {
				select = {
					action = nil, -- nil to use default put action
				},
				telescope = {
					mappings = nil, -- nil to use default mappings
				},
			},
			highlight = {
				on_put = true,
				on_yank = false,
				timer = 150,
			},
		},
		keys = {
			{ "<leader>p", "<cmd>YankyRingHistory<cr>", mode = { "n", "x" }, desc = "Open Yank History" },
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
			{ "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
			{ "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
			{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
		},
	},

	{
		"m4xshen/autoclose.nvim",
		enabled = false,
		event = "InsertEnter",
		opts = {
			keys = {
				["("] = { escape = false, close = true, pair = "()" },
				["["] = { escape = false, close = true, pair = "[]" },
				["{"] = { escape = false, close = true, pair = "{}" },

				[">"] = { escape = true, close = false, pair = "<>" },
				[")"] = { escape = true, close = false, pair = "()" },
				["]"] = { escape = true, close = false, pair = "[]" },
				["}"] = { escape = true, close = false, pair = "{}" },

				['"'] = { escape = true, close = true, pair = '""' },
				["'"] = { escape = true, close = true, pair = "''" },
				["`"] = { escape = true, close = true, pair = "``" },
			},
			options = {
				disabled_filetypes = { "text" },
				disable_when_touch = true,
				touch_regex = "[%w(%[{]",
				pair_spaces = false,
				auto_indent = true,
				disable_command_mode = false,
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		enabled = true,
		event = "InsertEnter",
		opts = {
			check_ts = true,
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				before_key = "h",
				after_key = "l",
				cursor_pos_before = true,
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				manual_position = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		},
	},

	{
		"nat-418/boole.nvim",
		enabled = true,
		keys = {
			{ "<C-a>" },
			{ "<C-x>" },
		},
		config = function()
			require("boole").setup({
				mappings = {
					increment = "<C-a>",
					decrement = "<C-x>",
				},
				additions = {},
				allow_caps_additions = {
					-- { "right", "left" },
				},
			})
		end,
	},

	{
		"mizlan/iswap.nvim",
		opts = {
			-- The keys that will be used as a selection, in order
			-- ('asdfghjklqwertyuiopzxcvbnm' by default)
			keys = "qwertyuiop",

			-- Grey out the rest of the text when making a selection
			-- (enabled by default)
			grey = "disable",

			-- Highlight group for the sniping value (asdf etc.)
			-- default 'Search'
			hl_snipe = "DiagnosticVirtualTextError",

			-- Highlight group for the visual selection of terms
			-- default 'Visual'
			hl_selection = "DiagnosticVirtualTextHint",

			-- Highlight group for the greyed background
			-- default 'Comment'
			hl_grey = "LineNr",

			-- Post-operation flashing highlight style,
			-- either 'simultaneous' or 'sequential', or false to disable
			-- default 'sequential'
			flash_style = "simultaneous",

			-- Highlight group for flashing highlight afterward
			-- default 'IncSearch'
			hl_flash = "DiagnosticVirtualTextInfo",

			-- Move cursor to the other element in ISwap*With commands
			-- default false
			move_cursor = true,

			-- Automatically swap with only two arguments
			-- default nil
			autoswap = true,

			-- Other default options you probably should not change:
			debug = nil,
			hl_grey_priority = "1000",
		},
		keys = {
			{ "<leader>ss", "<cmd>ISwap<cr>", desc = "Swap" },
			{ "<leader>sw", "<cmd>ISwapWith<cr>", desc = "Swap with" },
			{ "<leader>sh", "<cmd>ISwapWithLeft<cr>", desc = "Swap left" },
			{ "<leader>sl", "<cmd>ISwapWithRight<cr>", desc = "Swap right" },
		},
	},

	{
		"jake-stewart/multicursor.nvim",
		enabled = true,
		branch = "1.0",
		keys = function()
			local mc = require("multicursor-nvim")
			return {
				{
					mode = { "n", "x" },
					"<A-Up>",
					function()
						mc.lineAddCursor(-1)
					end,
				},
				{
					mode = { "n", "x" },
					"<A-Down>",
					function()
						mc.lineAddCursor(1)
					end,
				},
				{
					mode = { "n", "x" },
					"<leader><up>",
					function()
						mc.lineSkipCursor(-1)
					end,
				},
				{
					mode = { "n", "x" },
					"<leader><down>",
					function()
						mc.lineSkipCursor(1)
					end,
				},

				-- Add or skip adding a new cursor by matching word/selection
				{
					mode = { "n", "x" },
					"<leader>n",
					function()
						mc.matchAddCursor(1)
					end,
				},
				{
					mode = { "n", "x" },
					"<leader>s",
					function()
						mc.matchSkipCursor(1)
					end,
				},
				{
					mode = { "n", "x" },
					"<leader>N",
					function()
						mc.matchAddCursor(-1)
					end,
				},
				{
					mode = { "n", "x" },
					"<leader>S",
					function()
						mc.matchSkipCursor(-1)
					end,
				},
			}
		end,
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			mc.addKeymapLayer(function(layerSet)
				-- Select a different cursor as the main one.
				layerSet({ "n", "x" }, "<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "<right>", mc.nextCursor)

				-- Delete the main cursor.
				layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { reverse = true })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { reverse = true })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},
}
