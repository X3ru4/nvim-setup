return {
	'nvim-mini/mini.tabline',
	version = false,
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		always_show = false,
		tabpage_section = 'left',

		format = function(bufnr, label)
			return ' '
				.. require('mini.icons').get('file', label)
				.. ' '
				.. label
				.. (vim.bo[bufnr].modified and ' • ' or ' ')
		end,
	},
}
