return {

	{
		"folke/flash.nvim",
		enabled = true,
		opts = {
			label = {
				uppercase = true,
				-- reuse = "none",
				rainbow = {
					enabled = true,
					-- number between 1 and 9
					shade = 7,
				},
			},
			jump = {
				-- add pattern to search history
				history = false,
				-- add pattern to search register
				register = false,
				-- clear highlight after jump
				nohlsearch = false,
				-- automatically jump when there is only one match
				autojump = true,
			},
			prompt = {
				enabled = false,
			},
			highlight = {
				backdrop = false,
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
				nowait = true,
				remap = true,
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
				nowait = true,
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
				nowait = true,
			},
		},
	},

	{
		url = "https://codeberg.org/andyg/leap.nvim",
		enabled = false,
		event = "VeryLazy",
		keys = {
			{
				"s",
				"<Plug>(leap)",
				mode = { "n", "x", "o" },
				nowait = true,
				remap = true,
			},
			{
				"S",
				"<Plug>(leap-from-window)",
				mode = "n",
				nowait = true,
			},
			{
				"R",
				function()
					require("leap.treesitter").select({
						opts = require("leap.user").with_traversal_keys("R", "r"),
					})
				end,
				mode = { "x", "o" },
			},
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end

			leap.opts.preview = function(ch0, ch1, ch2)
				return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
			end

			leap.opts.equivalence_classes = {
				" \t\r\n",
				"([{",
				")]}",
				"'\"`",
			}

			require("leap.user").set_repeat_keys("<enter>", "<backspace>")

			-- vim.keymap.del({ "x", "o" }, "x")
			-- vim.keymap.del({ "x", "o" }, "X")
		end,
	},

	{
		"smoka7/hop.nvim",
		enabled = false,
		keys = {
			{ "f" },
			{ "F" },
			{ "t" },
			{ "T" },
		},
		version = "*",
		config = function()
			-- place this in one of your configuration file(s)
			local hop = require("hop")
			hop.setup({
				keys = "etovxqpdygfblzhckisuran",
			})
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
			end, { remap = true })
			vim.keymap.set("", "t", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "T", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
			end, { remap = true })
		end,
	},
}
