return {

	{
		"karb94/neoscroll.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			mappings = { -- Keys to be mapped to their corresponding default scrolling animation
				"<C-u>",
				"<C-d>",
				"<C-b>",
				"<C-f>",
				"<C-y>",
				"<C-e>",
				"zt",
				"zz",
				"zb",
			},
			hide_cursor = true, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling downwards
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
			duration_multiplier = 1.0, -- Global duration multiplier
			easing = "linear", -- Default easing function
			pre_hook = nil, -- Function to run before the scrolling animation starts
			post_hook = nil, -- Function to run after the scrolling animation ends
			performance_mode = false, -- Disable "Performance Mode" on all buffers.
			ignored_events = { -- Events ignored while scrolling
				"WinScrolled",
				"CursorMoved",
			},
		},
	},

	{
		"declancm/cinnamon.nvim",
		enabled = true,
		version = "*", -- use latest release
		event = "VeryLazy",
		config = function()
			require("cinnamon").setup({
				-- Disable the plugin
				disabled = false,

				keymaps = {
					-- Enable the provided 'basic' keymaps
					basic = true,
					-- Enable the provided 'extra' keymaps
					extra = true,
				},

				---@class ScrollOptions
				options = {
					-- The scrolling mode
					-- `cursor`: animate cursor and window scrolling for any movement
					-- `window`: animate window scrolling ONLY when the cursor moves out of view
					mode = "cursor",

					-- Only animate scrolling if a count is provided
					count_only = false,

					-- Delay between each movement step (in ms)
					delay = 9.396,

					max_delta = {
						-- Maximum distance for line movements before scroll
						-- animation is skipped. Set to `false` to disable
						line = false,
						-- Maximum distance for column movements before scroll
						-- animation is skipped. Set to `false` to disable
						column = false,
						-- Maximum duration for a movement (in ms). Automatically scales the
						-- delay and step size
						time = 1000,
					},

					step_size = {
						-- Number of cursor/window lines moved per step
						vertical = 1,
						-- Number of cursor/window columns moved per step
						horizontal = 2,
					},

					-- Optional post-movement callback. Not called if the movement is interrupted
					callback = function() end,
				},
			})

			local scroll = require("cinnamon").scroll

			vim.keymap.set({ "n", "x" }, "zh", function()
				scroll("zH")
			end, { desc = "Horizontal scroll" })
			vim.keymap.set({ "n", "x" }, "zl", function()
				scroll("zL")
			end, { desc = "Horizontal scroll" })
		end,
	},

	{
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		enabled = false,
		priority = 10, -- Low priority to catch other plugins' keybindings
		config = function()
			require("tiny-glimmer").setup()
		end,
	},

	{
		"y3owk1n/undo-glow.nvim",
		event = { "VeryLazy" },
		enabled = false,
		---@type UndoGlow.Config
		opts = {
			animation = {
				enabled = true,
				duration = 215,
				animtion_type = "slide",
				window_scoped = true,
			},
			highlights = {
				yank = {
					hl_color = { bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg },
				},
				paste = {
					hl_color = { bg = "#325B5B" },
				},
				search = {
					hl_color = { bg = "#5C475C" },
				},
				comment = {
					hl_color = { bg = "#7A5A3D" },
				},
				cursor = {
					hl_color = { bg = "#793D54" },
				},
			},
			priority = 2048 * 3,
		},
		keys = {
			{
				"p",
				function()
					require("undo-glow").paste_below({
						animation = {
							animation_type = "zoom",
							duration = 200,
						},
					})
				end,
				mode = "n",
				desc = "Paste below with highlight",
				noremap = true,
			},
			{
				"P",
				function()
					require("undo-glow").paste_above({
						animation = {
							animation_type = "zoom",
							duration = 200,
						},
					})
				end,
				mode = "n",
				desc = "Paste above with highlight",
				noremap = true,
			},
			-- {
			-- 	"gc",
			-- 	function()
			-- 		-- This is an implementation to preserve the cursor position
			-- 		local pos = vim.fn.getpos(".")
			-- 		vim.schedule(function()
			-- 			vim.fn.setpos(".", pos)
			-- 		end)
			-- 		return require("undo-glow").comment({
			-- 			animation = {
			-- 				animation_type = "zoom",
			-- 			},
			-- 		})
			-- 	end,
			-- 	mode = { "n", "x" },
			-- 	desc = "Toggle comment with highlight",
			-- 	expr = true,
			-- 	noremap = true,
			-- },
			-- {
			-- 	"gc",
			-- 	function()
			-- 		require("undo-glow").comment_textobject({
			-- 			animation = {
			-- 				animation_type = "zoom",
			-- 			},
			-- 		})
			-- 	end,
			-- 	mode = "o",
			-- 	desc = "Comment textobject with highlight",
			-- 	noremap = true,
			-- },
			-- {
			-- 	"gcc",
			-- 	function()
			-- 		return require("undo-glow").comment_line({
			-- 			animation = {
			-- 				animation_type = "zoom",
			-- 			},
			-- 		})
			-- 	end,
			-- 	mode = "n",
			-- 	desc = "Toggle comment line with highlight",
			-- 	expr = true,
			-- 	noremap = true,
			-- },
		},
		init = function()
			vim.api.nvim_create_autocmd("TextYankPost", {
				desc = "Highlight when yanking (copying) text",
				callback = function()
					require("undo-glow").yank({
						animation = {
							animation_type = "zoom",
							duration = 200,
						},
					})
				end,
			})

			-- This only handles neovim instance and do not highlight when switching panes in tmux
			-- vim.api.nvim_create_autocmd("CursorMoved", {
			-- 	desc = "Highlight when cursor moved significantly",
			-- 	callback = function()
			-- 		require("undo-glow").cursor_moved({
			-- 			animation = {
			-- 				animation_type = "slide",
			-- 			},
			-- 		})
			-- 	end,
			-- })

			-- vim.api.nvim_create_autocmd("CmdLineLeave", {
			-- 	pattern = { "/", "?" },
			-- 	desc = "Highlight when search cmdline leave",
			-- 	callback = function()
			-- 		require("undo-glow").search_cmd({
			-- 			animation = {
			-- 				animation_type = "zoom",
			-- 			},
			-- 		})
			-- 	end,
			-- })
		end,
	},

	{
		"sphamba/smear-cursor.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			stiffness = 0.5,
			trailing_stiffness = 0.5,
			matrix_pixel_threshold = 0.5,
		},
	},
}
