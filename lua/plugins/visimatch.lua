return {
	'wurli/visimatch.nvim',
	enabled = false,
	event = 'ModeChanged *:[vV\22]',
	opts = {
		-- The minimum number of selected characters required to trigger highlighting
		chars_lower_limit = 3,
		-- The maximum number of selected lines to trigger highlighting for
		lines_upper_limit = 30,
	},
}
