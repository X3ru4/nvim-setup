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
		options = {
			-- Whether to first check input line to be a border of adjacent scope.
			-- Use it if you want to place cursor on function header to get scope of
			-- its body.
			try_as_border = true,
		},
		symbol = '│', -- │
	},
}
