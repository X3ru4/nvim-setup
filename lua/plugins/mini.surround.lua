return {
	'nvim-mini/mini.surround',
	version = false,
	keys = {
		{ 'Sa', mode = { 'n', 'x', 'v' } },
		{ 'Sr', mode = { 'n', 'x', 'v' } },
		{ 'Sd', mode = { 'n', 'x', 'v' } },
		{ 'Sf', mode = { 'n', 'x', 'v' } },
		{ 'SF', mode = { 'n', 'x', 'v' } },
	},
	opts = {
		mappings = {
			add = 'Sa',
			delete = 'Sd',
			find = 'Sf',
			find_left = 'SF',
			replace = 'Sr',
			suffix_last = 'l',
			suffix_next = 'n',
		},
		silent = true,
	},
}
