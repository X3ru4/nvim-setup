vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'
-- This module is needed for building/loading the theme.
package.preload['nvconfig'] = function()
	return {
		base46 = {
			theme = 'onedark',
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
			changed_themes = {},
			transparency = false,
			theme_toggle = { 'onedark', 'one_light' },
		},
		ui = { cmp = {}, telescope = { style = 'borderless' }, statusline = { enabled = true, theme = 'default' } },
		cheatsheet = {},
	}
end

return {
	'nvchad/base46',
	name = 'nvchad',
	dependencies = { 'nvim-lua/plenary.nvim' },
	build = function()
		require('base46').load_all_highlights()
	end,
	config = function()
		-- Override the default options.
		-- If you configure and run it again, the changes won't apply; you must use the command `:Lazy build nvchad`.
		local opts = {
			-- All valid themes https://github.com/NvChad/base46/tree/v3.0/lua/base46/themes press `gx` to open.
			theme = 'blossom_light',
			transparency = true,
		}

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

		require('nvconfig').base46 = vim.tbl_extend('force', require('nvconfig').base46, opts)

		for _, name in ipairs(integrations) do
			dofile(vim.g.base46_cache .. name)
		end

		local palette = {
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

				NonText = { fg = palette.base30.one_bg3 },

				MiniIconsGrey = { fg = palette.base30.grey },
				MiniIconsAzure = { fg = palette.base30.nord_blue },
				MiniIconsPurple = { fg = palette.base30.purple },
				MiniIconsGreen = { fg = palette.base30.green },
				MiniIconsBlue = { fg = palette.base30.blue },
				MiniIconsCyan = { fg = palette.base30.cyan },
				MiniIconsOrange = { fg = palette.base30.orange },
				MiniIconsRed = { fg = palette.base30.red },
				MiniIconsYellow = { fg = palette.base30.yellow },
			},
			extra = {
				hl.modify('NormalFloat', { fg = palette.base30.white }),
			},
		})
	end,
}
