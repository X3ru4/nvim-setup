return {
	'nvim-mini/mini.indentscope',
	event = 'BufReadPost',
	opts = {
		draw = { delay = 0 },
		symbol = '│',
	},
}
