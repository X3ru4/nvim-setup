return {
	'nvim-mini/mini.indentscope',
	cond = vim.g.plugin_indent == 'mini',
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
