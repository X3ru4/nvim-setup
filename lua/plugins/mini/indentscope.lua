return {
	'nvim-mini/mini.indentscope',
	cond = vim.g.indent_guide == 'mini',
	event = 'BufReadPost',
	keys = {
		{
			'<leader>ci',
			function()
				vim.b.miniindentscope_disable = not vim.b.miniindentscope_disable
			end,
			desc = 'Toggle indent guides',
		},
	},
	opts = {
		draw = {
			delay = 0,
			-- disable animation
			-- animation = function()
			-- 	return 0
			-- end,
		},
		symbol = '▏', -- │
	},
}
