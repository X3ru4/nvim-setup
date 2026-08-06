vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'
-- This module is needed for building/loading the theme.
package.preload['nvconfig'] = function()
	return {
		base46 = {
			theme = 'onedark',
			transparency = false,
			hl_add = {},
			hl_override = {},
			-- Add integrations to this table to create corresponding caches for each integration per build.
			integrations = {
				-- All valid integration: https://github.com/NvChad/base46/tree/v3.0/lua/base46/integrations
				'alpha',
				'blink-pair',
				'render-markdown',
				'leap',
				'mini-tabline',
			},
			-- The following configurations are not required for setup but are essential.
			changed_themes = {},
			theme_toggle = { 'onedark', 'one_light' },
		},
		ui = { cmp = {}, telescope = { style = 'borderless' }, statusline = { enabled = true, theme = 'default' } },
		cheatsheet = {},
	}
end

-- The integrations will be loaded.
local integrations = {
	'alpha',
	'blink',
	'defaults',
	'git',
	'lsp',
	'mason',
	'statusline',
	'syntax',
	'treesitter',
	'mini-tabline',
	'blink-pair',
	'leap',
	'render-markdown',
}

return {
	'nvchad/base46',
	name = 'nvchad',
	dependencies = { 'nvim-lua/plenary.nvim' },
	build = function()
		require('base46').load_all_highlights()
	end,
	config = function()
		local config = require('nvconfig')
		-- If you change the configuration, you will be forced to rebuild `:Lazy build nvchad`
		config.base46.theme = 'gruvbox_light'
		config.base46.transparency = false

		for _, name in ipairs(integrations) do
			dofile(vim.g.base46_cache .. name)
		end
		vim.g.colors_name = 'nvchad'

		local colors = {
			base16 = require('base46').get_theme_tb('base_16'),
			base30 = require('base46').get_theme_tb('base_30'),
		}
		local hl = vimu.highlight
		hl.apply({
			basic = {
				ModeOther = { link = 'St_ConfirmMode' },
				ModeNormal = { link = 'St_NormalMode' },
				ModeInsert = { link = 'St_InsertMode' },
				ModeVisual = { link = 'St_VisualMode' },
				ModeCommand = { link = 'St_CommandMode' },
				ModeReplace = { link = 'St_ReplaceMode' },

				FloatTitle = {
					fg = colors.base30.black,
					bg = colors.base30.blue,
					bold = true,
				},
				FloatFooter = { link = 'FloatTitle' },

				MiniIconsGrey = { fg = colors.base30.grey },
				MiniIconsAzure = { fg = colors.base30.nord_blue },
				MiniIconsPurple = { fg = colors.base30.purple },
				MiniIconsGreen = { fg = colors.base30.green },
				MiniIconsBlue = { fg = colors.base30.blue },
				MiniIconsCyan = { fg = colors.base30.cyan },
				MiniIconsOrange = { fg = colors.base30.orange },
				MiniIconsRed = { fg = colors.base30.red },
				MiniIconsYellow = { fg = colors.base30.yellow },

				SnacksIndent = { fg = colors.base30.line },
				SnacksIndentScope = { fg = colors.base30.grey },
			},
			extra = {
				hl.modify('NormalFloat', { fg = colors.base30.white }),

				-- Syntax
				hl.modify('Keyword', { italic = true }),
				hl.modify('@keyword', { italic = true }),
				hl.modify('@keyword.function', { italic = true }),
				hl.modify('@keyword.operator', { italic = true }),
				hl.modify('@keyword.conditional', { italic = true }),
				hl.modify('@keyword.conditional.ternary', { italic = true }),
				hl.modify('Function', { bold = true }),
				hl.modify('@function', { bold = true }),
				hl.modify('@function.call', { bold = true }),
				hl.modify('@function.method', { bold = true }),
				hl.modify('@function.method.call', { bold = true }),
			},
		})
	end,
}
