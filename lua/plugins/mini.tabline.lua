return {
	'nvim-mini/mini.tabline',
	version = false,
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		always_show = false,
		tabpage_section = 'right',

		format = function(bufnr, label)
			return ' '
				.. (MiniIcons and MiniIcons.get('file', label) or '')
				.. ' '
				.. label
				.. (vim.bo[bufnr].modified and '  ' or ' ')
		end,
	},
}
