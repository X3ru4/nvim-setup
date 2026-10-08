return {
	'X3ru4/boole.nvim',
	event = 'BufReadPost',
	---@module 'boole'
	---@type boole.config
	opts = {
		presets = { 'colors', 'weekdays', 'months' },
		additions = {
			{ 'continue', 'break' },
		},
		allow_caps_additions = {
			{ 'true', 'false' },
			{ 'light', 'dark' },
		},
		maximum_loop = false,
	},
}
