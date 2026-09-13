return {
	'Wansmer/sibling-swap.nvim',
	keys = {
		{ '<leader>sh', desc = 'Swap left' },
		{ '<leader>sl', desc = 'Swap right' },
		{ '<leader>soh', desc = 'Swap opp left' },
		{ '<leader>sol', desc = 'Swap opp right' },
	},
	opts = {
		keymaps = {
			['<leader>sl'] = 'swap_with_right',
			['<leader>sh'] = 'swap_with_left',
			['<leader>sol'] = 'swap_with_right_with_opp',
			['<leader>soh'] = 'swap_with_left_with_opp',
		},
	},
}
