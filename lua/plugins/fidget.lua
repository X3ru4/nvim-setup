return {
	'j-hui/fidget.nvim',
	event = 'VeryLazy',
	config = function()
		local fidget = require('fidget')

		fidget.setup({
			progress = {
				display = {
					done_icon = '✓',
					progress_icon = { 'meter' },
				},
			},
		})
		vim.notify = fidget.notify
		vim.keymap.set('n', '<C-h>', fidget.notification.show_history, { desc = 'Show notification history' })
	end,
}
