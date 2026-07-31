return {
	'nvim-mini/mini.tabline',
	version = false,
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		always_show = false,
		tabpage_section = 'left',

		format = function(bufnr, label)
			local current_buf = vim.api.nvim_get_current_buf() == bufnr

			return (current_buf and '› ' or ' ')
				.. require('mini.icons').get('file', label)
				.. ' '
				.. label
				.. (vim.bo[bufnr].modified and ' 󰍳' or '')
				.. (current_buf and ' ‹' or ' ')
		end,
	},
}
