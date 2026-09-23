return {
	'nvim-mini/mini-git',
	event = 'VeryLazy',
	config = function()
		require('mini.git').setup()

		vim.keymap.set('n', '<leader>gr', MiniGit.show_range_history, { desc = 'Show range history' })
		vim.keymap.set('n', '<leader>gd', MiniGit.show_diff_source, { desc = 'Show diff source' })
		vim.keymap.set('n', '<leader>gc', MiniGit.show_at_cursor, { desc = 'Show at cursor' })
	end,
}
