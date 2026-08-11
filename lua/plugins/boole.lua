return true
		and {
			'exp_boole.nvim',
			-- enabled = false,
			dev = true,
			keys = {
				{ mode = { 'n', 'x' }, '<C-a>' },
				{ mode = { 'n', 'x' }, '<C-x>' },
			},
			opts = {
				presets = { 'colors', 'weekdays', 'months' },
				mappings = {
					increment = '<C-a>',
					decrement = '<C-x>',
				},
				additions = {
					{ 'true', 'false' },
					{ '🤣🤣', '🤣😭' },
					{ '>=', '<=' },
					{ '₫', '₹' },
				},
			},
			-- false,false,false
			-- false,false,false
			-- false,false,false
			-- false,false,false
			-- false,false,false
			-- mon
			-- mon
			-- mon
			-- mon
			-- mon
			-- mon
			-- mon
			-- <=
		}
	or {
		'X3ru4/boole.nvim',
		keys = { '<C-a>', '<C-x>' },
		opts = {
			presets = { 'colors', 'weekdays', 'months' },
			mappings = {
				increment = '<C-a>',
				decrement = '<C-x>',
			},
			additions = {
				{ 'true', 'false' },
				{ '🤣🤣', '🤣😭' },
			},
		},
	}
