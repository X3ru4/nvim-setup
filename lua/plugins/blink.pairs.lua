return {
	'saghen/blink.pairs',
	dependencies = 'saghen/blink.lib',
	version = '*',
	build = function()
		require('blink.pairs').build():pwait(60000)
	end,
	event = 'VeryLazy',
	config = function()
		require('blink.pairs').setup({
			mappings = {
				enabled = true,
				cmdline = true,
				wrap = {
					['<C-b>'] = 'motion',
					['<A-b>'] = 'motion_reverse',
				},
				pairs = {},
			},
			highlights = {
				enabled = true,
				groups = {
					'BlinkPairsBlue',
					'BlinkPairsPurple',
					'BlinkPairsGreen',
					'BlinkPairsYellow',
					'BlinkPairsOrange',
					'BlinkPairsRed',
				},
				unmatched_group = 'BlinkPairsUnmatched',
				matchparen = { enabled = false },
			},
		})

		vim.api.nvim_set_hl(0, 'BlinkPairsUnmatched', { link = 'Error' })
	end,
}
