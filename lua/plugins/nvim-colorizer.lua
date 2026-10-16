return {
	'catgoose/nvim-colorizer.lua',
	event = 'BufReadPost',
	cmd = 'ColorizerToggle',
	keys = {
		{ '<leader>cC', '<cmd>ColorizerToggle<cr>', desc = 'ColorizerToggle' },
	},
	opts = {
		options = {
			parsers = {
				css = false, -- preset: enables names, hex, rgb, hsl, oklch
				css_fn = false,
				tailwind = { enable = true },
				names = { enable = true },
				rgb = { enable = false },
				hsl = { enable = false },
				oklch = { enable = false },
				xterm = { enable = true },
				hex = {
					default = true,
					rgb = false,
					rgba = false,
					rrggbb = true,
					rrggbbaa = true,
					aarrggbb = false,
				},
			},
			display = {
				mode = nve.has_nerdfont and 'virtualtext' or 'background',
				virtualtext = {
					char = '',
					position = 'after',
					hl_mode = 'foreground',
				},
			},
		},
		-- filetypes = {
		-- 	'mininotify-history',
		-- },
	},
}
