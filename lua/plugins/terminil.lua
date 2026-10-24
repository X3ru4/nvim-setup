return {
	'X3ru4/terminil.nvim',
	event = 'VeryLazy',
	config = function()
		local terminil = require('terminil')
		local helper = terminil.helper
		terminil.setup({
			term_opts = {
				shell = 'fish',
			},
		})
	end,
}
