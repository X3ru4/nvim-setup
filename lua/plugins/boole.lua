return {
	'X3ru4/boole.nvim',
	event = 'BufReadPost',
	opts = {
		presets = { 'colors', 'weekdays', 'months' },
		additions = {
			{ 'true', 'false' },
		},
	},
}
