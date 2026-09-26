return {
	'saghen/blink.indent',
	cond = vim.g.indent_guide == 'blink',
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
