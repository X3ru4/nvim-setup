return {
	'saghen/blink.indent',
	event = 'BufReadPost',
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
