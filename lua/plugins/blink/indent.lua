return {
	'saghen/blink.indent',
	cond = vime.indent_guide == 'blink',
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
	---@module 'blink.indent'
	---@type blink.indent.Config
	opts = {
		static = {
			char = vime.indent_guide_char,
		},
		scope = {
			char = vime.indent_guide_char,
			indent_at_cursor = true,
			highlights = { 'BlinkIndentScope' },
		},
	},
}
