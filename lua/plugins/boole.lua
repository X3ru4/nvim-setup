return {
	'X3ru4/boole.nvim',
	keys = { '<C-a>', '<C-x>' },
	opts = {
		-- presets = { 'colors', 'dayweeks', 'months' },
		mappings = {
			increment = '<C-a>',
			decrement = '<C-x>',
		},
		additions = {
			{ 'true', 'false' },
			{ '>=', '<=', '>', '<' },
		},
	},
}
