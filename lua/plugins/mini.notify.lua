return {
	'nvim-mini/mini.notify',
	event = 'VeryLazy',
	version = false,
	keys = {
		{
			'<C-h>',
			function()
				require('mini.notify').show_history()
			end,
		},
	},
	config = function()
		local MiniNotify = require('mini.notify')

		MiniNotify.setup({
			-- Content management
			content = {
				format = function(notif)
					if notif.data.source == 'lsp_progress' then
						return notif.msg
					end
					return notif.level .. ': ' .. notif.msg
				end,
			},

			-- Notifications about LSP progress
			lsp_progress = { enable = true },

			-- Window options
			window = {
				-- Floating window config
				config = {
					border = nil,
					title = ' Notifications ',
					title_pos = 'center',
				},

				-- Maximum window width as share (between 0 and 1) of available columns
				max_width_share = 0.382,
				winblend = vim.o.winblend,
			},
		})

		vim.notify = MiniNotify.make_notify({
			ERROR = { duration = 4000 },
			WARN = { duration = 3000 },
			INFO = { duration = 2000 },
		})
	end,
}
