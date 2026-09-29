return {
	-- uses mini.icons
	'nvim-mini/mini.tabline',
	event = { 'BufReadPre', 'BufNewFile', 'TabEnter' },
	opts = {
		tabpage_section = 'right',
		format = function(bufnr, label)
			return ' '
			  .. MiniIcons.get('file', label)
				.. ' '
				.. label
				.. (vim.bo[bufnr].modified and ' ◉ ' or ' ') end,
	},
}
