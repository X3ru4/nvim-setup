return {
	'nvim-mini/mini.surround',
	version = false,
	keys = {
		{ '<leader>sa', mode = { 'n', 'x', 'v' } },
		{ '<leader>sr', mode = { 'n', 'x', 'v' } },
		{ '<leader>sd', mode = { 'n', 'x', 'v' } },
		{ '<leader>sf', mode = { 'n', 'x', 'v' } },
		{ '<leader>sF', mode = { 'n', 'x', 'v' } },
	},
	opts = {
		mappings = {
			add = '<leader>sa',
			delete = '<leader>sd',
			find = '<leader>sf',
			find_left = '<leader>sF',
			replace = '<leader>sr',
			suffix_last = 'l',
			suffix_next = 'n',
		},
		silent = true,
	},
}
