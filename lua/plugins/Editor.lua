return {

	{
		"nat-418/boole.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
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
		"smjonas/inc-rename.nvim",
		opts = {},
		keys = {
			{ "grn", ":IncRename ", desc = "Rename" },
		},
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
				{
					mode = { "n", "x" },
					"<C-q>",
					function()
						mc.toggleCursor()
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

	{
		"catgoose/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			filetypes = { "*" }, -- Filetype options.  Accepts table like `user_default_options`
			buftypes = {}, -- Buftype options.  Accepts table like `user_default_options`
			-- Boolean | List of usercommands to enable.  See User commands section.
			user_commands = true, -- Enable all or some usercommands
			lazy_load = false, -- Lazily schedule buffer highlighting setup function
			user_default_options = {
				names = true, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
				names_opts = { -- options for mutating/filtering names.
					lowercase = true, -- name:lower(), highlight `blue` and `red`
					camelcase = true, -- name, highlight `Blue` and `Red`
					uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
					strip_digits = false, -- ignore names with digits,
					-- highlight `blue` and `red`, but not `blue3` and `red4`
				},
				-- Expects a table of color name to #RRGGBB value pairs.  # is optional
				-- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
				-- Set to false to disable, for example when setting filetype options
				names_custom = false, -- Custom names to be highlighted: table|function|false
				RGB = true, -- #RGB hex codes
				RGBA = true, -- #RGBA hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS *features*:
				-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
				css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
				tailwind = false, -- Enable tailwind colors
				tailwind_opts = { -- Options for highlighting tailwind names
					update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
				},
				-- parsers can contain values used in `user_default_options`
				sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
				xterm = false, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
				-- Highlighting mode.  'background'|'foreground'|'virtualtext'
				mode = "background", -- Set the display mode
				-- Virtualtext character to use
				virtualtext = "█",
				-- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
				virtualtext_inline = true,
				-- Virtualtext highlight mode: 'background'|'foreground'
				virtualtext_mode = "foreground",
				-- update color values even if buffer is not focused
				-- example use: cmp_menu, cmp_docs
				always_update = true,
				-- hooks to invert control of colorizer
				hooks = {
					-- called before line parsing.  Accepts boolean or function that returns boolean
					-- see hooks section below
					disable_line_highlight = false,
				},
			},
		},
	},

	{
		enabled = false,
		"RRethy/vim-illuminate",
		event = "LspAttach",
		config = function()
			-- default configuration
			require("illuminate").configure({
				-- providers: provider used to get references in the buffer, ordered by priority
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				-- delay: delay in milliseconds
				delay = 100,
				-- filetype_overrides: filetype specific overrides.
				-- The keys are strings to represent the filetype while the values are tables that
				-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
				filetype_overrides = {},
				-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
				},
				-- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
				-- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
				filetypes_allowlist = {},
				-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
				-- See `:help mode()` for possible values
				modes_denylist = {},
				-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
				-- See `:help mode()` for possible values
				modes_allowlist = {},
				-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_denylist = {},
				-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
				-- Only applies to the 'regex' provider
				-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
				providers_regex_syntax_allowlist = {},
				-- under_cursor: whether or not to illuminate under the cursor
				under_cursor = true,
				-- large_file_cutoff: number of lines at which to use large_file_config
				-- The `under_cursor` option is disabled when this cutoff is hit
				large_file_cutoff = 10000,
				-- large_file_config: config to use for large files (based on large_file_cutoff).
				-- Supports the same keys passed to .configure
				-- If nil, vim-illuminate will be disabled for large files.
				large_file_overrides = nil,
				-- min_count_to_highlight: minimum number of matches required to perform highlighting
				min_count_to_highlight = 1,
				-- should_enable: a callback that overrides all other settings to
				-- enable/disable illumination. This will be called a lot so don't do
				-- anything expensive in it.
				should_enable = function(bufnr)
					return true
				end,
				-- case_insensitive_regex: sets regex case sensitivity
				case_insensitive_regex = false,
				-- disable_keymaps: disable default keymaps
				disable_keymaps = false,
			})
		end,
	},

	{
		enabled = false,
		"folke/flash.nvim",
		opts = {},
		keys = {
			{
				"gs",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
				nowait = true,
			},
			{
				"gS",
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
		"ggandor/leap.nvim",
		enabled = true,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
			{ "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
		},
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
			vim.keymap.del({ "x", "o" }, "x")
			vim.keymap.del({ "x", "o" }, "X")
		end,
	},
}
