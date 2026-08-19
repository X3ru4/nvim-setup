return {
	'nvim-mini/mini.surround',
	version = false,
	keys = {
		{ 'ta', mode = { 'n', 'x', 'v' } },
		{ 'tr', mode = { 'n', 'x', 'v' } },
		{ 'td', mode = { 'n', 'x', 'v' } },
		{ 'tf', mode = { 'n', 'x', 'v' } },
		{ 'tF', mode = { 'n', 'x', 'v' } },
	},
	opts = {
		mappings = {
			add = 'ta',
			delete = 'td',
			find = 'tf',
			find_left = 'tF',
			replace = 'tr',
			suffix_last = 'l',
			suffix_next = 'n',
		},
		silent = true,
	},
}
