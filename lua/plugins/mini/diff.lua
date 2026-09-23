return {
	'nvim-mini/mini.diff',
	event = 'BufReadPost',
	keys = {
		{
			'<leader>go',
			function()
				MiniDiff.toggle_overlay(0)
			end,
			desc = 'Toggle diff overlay',
		},
	},
	opts = {
		view = {
			-- Visualization style. Possible values are 'sign' and 'number'.
			---@type "sign"|"number"
			style = 'number',

			-- Signs used for hunks with 'sign' view
			signs = { add = '', change = '', delete = '' },
		},
	},
}
