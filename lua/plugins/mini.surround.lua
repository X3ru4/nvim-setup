return {
	'nvim-mini/mini.surround',
	version = false,
	keys = {
		{ 'ma', mode = { 'n', 'x', 'v' } },
		{ 'mr', mode = { 'n', 'x', 'v' } },
		{ 'md', mode = { 'n', 'x', 'v' } },
		{ 'mf', mode = { 'n', 'x', 'v' } },
		{ 'mF', mode = { 'n', 'x', 'v' } },
	},
	opts = {
		mappings = {
			add = 'ma',
			delete = 'md',
			find = 'mf',
			find_left = 'mF',
			highlight = 'fh',
			replace = 'mr',
			suffix_last = 'l',
			suffix_next = 'n',
		},
		silent = true,
	},
}
