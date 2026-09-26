return {
	'X3ru4/boole.nvim',
	event = 'BufReadPost',
	opts = {
		presets = { 'colors', 'weekdays', 'months' },
		additions = {
			{ 'continue', 'break' },
		},
		allow_caps_additions = {
			{ 'true', 'false' },
			{ 'light', 'dark' },
		},
	},
}
