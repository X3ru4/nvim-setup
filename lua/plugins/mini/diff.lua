return {
	'nvim-mini/mini.diff',
	event = 'BufReadPost',
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
