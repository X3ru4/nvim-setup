return {
	'j-hui/fidget.nvim',
	event = 'VeryLazy',
	config = function()
		local fidget = require('fidget')

		fidget.setup({
			progress = {
				display = {
					done_icon = '✓',
					progress_icon = nve.has_nerdfont and { { '󰸵', '󰸸', '󰸷', '󰸴' }, period = 0.5 } or nil,
				},
			},
			notification = {
				override_vim_notify = true,
			},
		})

		vim.keymap.set('n', '<leader>hs', fidget.notification.show_history, { desc = 'Show notification history' })
		vim.keymap.set('n', '<leader>hc', fidget.notification.clear, { desc = 'Clear notification history' })
	end,
}
