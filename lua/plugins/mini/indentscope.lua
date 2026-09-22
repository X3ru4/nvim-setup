return {
	'nvim-mini/mini.indentscope',
  enabled = vim.g.plugin_indent == 'mini.indentscope',
	event = 'BufReadPost',
	opts = {
		draw = { delay = 0 },
		symbol = '│',
	},
}
