return {
	'folke/persistence.nvim',
	opts = {},
	keys = {
		{
			'<leader>ss',
			function()
				require('persistence').load()
			end,
			desc = 'Session restore',
		},
		{
			'<leader>sS',
			function()
				require('persistence').select()
			end,
			desc = 'Session select',
		},
		{
			'<leader>se',
			function()
				require('persistence').load({ last = true })
			end,
			desc = 'Session restore last ses',
		},
		{
			'<leader>sd',
			function()
				require('persistence').stop()
			end,
			desc = 'Session skip',
		},
	},
}
