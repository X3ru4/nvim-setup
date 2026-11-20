return {
	'saghen/blink.indent',
	cond = false,
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
			-- whitespace_char = ' ',
			char = '▏',
		},
		scope = {
			char = '▏',
			indent_at_cursor = true,
			highlights = { 'BlinkIndentScope' },
		},
	},
}
