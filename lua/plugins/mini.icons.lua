return {
	'nvim-mini/mini.icons',
	event = 'VeryLazy',
	opts = {
		style = 'glyph',
		-- Customize per category. See `:h MiniIcons.config` for details.
		default = {},
		directory = {
			Download = { glyph = '󰉍', hl = 'MiniIconsOrange' },
			Movies = { glyph = '󰎁', hl = 'MiniIconsOrange' },
			utility = { glyph = '󰴉', hl = 'MiniIconsYellow' },
			config = { glyph = '󱁿', hl = 'MiniIconsGreen' },
			plugins = { glyph = '󱋣', hl = 'MiniIconsYellow' },
		},
		file = {
			['lazy.lua'] = { glyph = '󰒲', hl = 'MiniIconsBlue' },
			['autocmds.lua'] = { glyph = '󰁨', hl = 'MiniIconsAzure' },
			['usercmds.lua'] = { glyph = '󰘰', hl = 'MiniIconsAzure' },
			['options.lua'] = { glyph = '󰒓', hl = 'MiniIconsOrange' },
			['extra_options.lua'] = { glyph = '󰣖', hl = 'MiniIconsYellow' },
			['highlights.lua'] = { glyph = '󰛨', hl = 'MiniIconsAzure' },
			['keymaps.lua'] = { glyph = '󰌌', hl = 'MiniIconsAzure' },
			['icons.lua'] = { glyph = '', hl = 'MiniIconsAzure' },
		},
		filetype = {},
		extension = {},
		lsp = {},
		os = {},
	},
}
