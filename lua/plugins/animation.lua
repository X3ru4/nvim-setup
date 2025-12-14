return {

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
