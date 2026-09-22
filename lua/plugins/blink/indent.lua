return {
	'saghen/blink.indent',
	enabled = vim.g.plugin_indent == 'blink.indent',
	event = 'BufReadPost',
	keys = {
		{
			'<leader>ci',
			function()
				require('blink.indent').enable(not require('blink.indent').is_enabled({ bufnr = 0 }), { bufnr = 0 })
			end,
			desc = 'Toggle indent guides',
		},
	},
	--- @module 'blink.indent'
	--- @type blink.indent.Config
	opts = {
		-- thin: ▏, bold: ▎
		static = {
			char = '▎',
		},
		scope = {
			char = '▎',
			highlights = { 'BlinkIndentScope' },
		},
	},
}
