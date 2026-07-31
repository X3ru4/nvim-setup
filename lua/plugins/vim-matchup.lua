return {
	'andymass/vim-matchup',
	event = { 'BufReadPre', 'BufNewFile' },
	---@type matchup.Config
	opts = {
		text_obj = { enabled = 0 },
		motion = { enabled = 0 },
		mappings = { enabled = 0 },
		matchpref = { enabled = 0 },
		mouse = { enabled = 0 },
		surround = { enabled = 0 },
		matchparen = {
			enabled = 1,
			offscreen = {
				method = '',
				syntax_hl = 0,
			},
		},
		treesitter = {
			enabled = true,
			stopline = 500,
			disable_virtual_text = true,
		},
	},
}
