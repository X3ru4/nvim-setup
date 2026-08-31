return {
	'j-hui/fidget.nvim',
	event = 'VeryLazy',
	config = function()
		local fidget = require('fidget')
		fidget.setup({})
		vim.notify = fidget.notify
		vim.keymap.set('n', '<C-h>', fidget.notification.show_history, { desc = 'Show notification history' })
	end,
}
