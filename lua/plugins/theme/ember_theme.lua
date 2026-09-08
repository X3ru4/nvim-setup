return {
	'ember-theme/nvim',
	name = 'ember',
	config = function()
		require('ember').setup({
			variant = 'ember-light', -- "ember" | "ember-soft" | "ember-light"
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
				types = { bold = true },
			},
			dark_variant = 'ember', -- used by `ember-auto` when background = "dark"
			light_variant = 'ember-light',
		})
		require('ember').load('ember-auto')
		local hl = require('utils.highlight')
		local palette = require('ember.palette').get(require('ember').config.variant)

		hl.apply({
			basic = {
				MiniIconsGrey = { fg = palette.base4 },
				MiniIconsAzure = { fg = palette.steel },
				MiniIconsPurple = { fg = palette.mauve },
				MiniIconsGreen = { fg = palette.olive },
				MiniIconsBlue = { fg = palette.steel },
				MiniIconsCyan = { fg = palette.steel },
				MiniIconsOrange = { fg = palette.orange },
				MiniIconsRed = { fg = palette.coral },
				MiniIconsYellow = { fg = palette.gold },
				MiniTablineFill = { bg = palette.bg },

				LazyButton = { bg = palette.base1 },
				SnacksIndentScope = { fg = palette.sage },
			},
			extra = {
				hl.modify('MiniNotifyNormal', { bg = palette.bg_alt }),
				hl.modify('MiniNotifyBorder', { bg = palette.bg_alt }),
				hl.modify('MiniNotifyTitle', { bg = palette.bg_alt, bold = true }),

				hl.modify('FloatTitle', { fg = palette.coral, bg = palette.base0 }),
			},
		})
	end,
}
