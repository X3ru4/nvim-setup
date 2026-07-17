return {
	"nvim-mini/mini.notify",
	enabled = true,
	lazy = false,
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
				return string.format("%s %s", icons[notify.level], notify.msg)
			end,
			sort = function(notify_arr)
				table.sort(notify_arr, function(a, b)
					return a.ts_update < b.ts_update
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
				title = "",
				title_pos = "center",
				footer = "",
				footer_pos = "center",
			},

			-- Maximum window width as share (between 0 and 1) of available columns
			max_width_share = 0.382,
			winblend = 0,
		},
	},
}
