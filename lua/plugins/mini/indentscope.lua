return {
	'nvim-mini/mini.indentscope',
	cond = vim.g.indent_guide == 'mini',
	event = 'BufReadPost',
	opts = {
		draw = {
			delay = 0,
			-- disable animation
			-- animation = function()
			-- 	return 0
			-- end,
		},
		symbol = '▎', -- │
	},
}
