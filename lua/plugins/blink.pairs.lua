return {
	'saghen/blink.pairs',
	dependencies = 'saghen/blink.lib',
	version = '*',
	build = function()
		require('blink.pairs').build():pwait(60000)
	end,
	event = 'VeryLazy',
	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		mappings = {
			enabled = true,
			cmdline = true,
			wrap = {
				['<C-b>'] = 'motion',
				['<C-r>b'] = 'motion_reverse',
				['<C-l>'] = 'treesitter',
				['<C-h>'] = 'treesitter_reverse',
			},
			pairs = {},
		},
		highlights = {
			enabled = false,
			matchparen = { enabled = false },
		},
	},
}
