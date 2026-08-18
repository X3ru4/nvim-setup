return {
	'nvim-mini/mini.icons',
	version = false,
	event = 'VeryLazy',
	opts = {
		style = 'glyph',
		-- Customize per category. See `:h MiniIcons.config` for details.
		directory = {
			Download = { glyph = '󰉍', hl = 'MiniIconsOrange' },
			Movies = { glyph = '󰎁', hl = 'MiniIconsOrange' },
		},
	},
}
