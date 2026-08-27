return {
	'AvengeMedia/base46',
	name = 'base46',
	config = function()
		local base46 = require('base46')
		base46.setup({
			-- Each theme has a `type` field set to dark or light.
			-- If this is true, vim.o.background will be updated accordingly when a theme is loaded.
			set_background = true,
			-- If this is true, the 16 colors of neovim's terminal will be set accordingly when a theme is loaded.
			term_colors = true,
			-- Enable transparent background.
			transparency = false,

			-- Contrary to NvChad, all integrations are enabled by default.
			integrations = {
				blankline = false,
				blink = true,
				cmp = false,
				defaults = true,
				devicons = false,
				git = true,
				lsp = true,
				mason = true,
				neotest = false,
				nvcheatsheet = false,
				nvimtree = false,
				statusline = true,
				syntax = true,
				treesitter = true,
				tbline = false,
				telescope = false,
				whichkey = false,
				alpha = true,
				avante = false,
				['blink-pair'] = true,
				bufferline = false,
				codeactionmenu = false,
				dap = false,
				diffview = false,
				edgy = false,
				flash = false,
				['git-conflict'] = false,
				gitsigns = false,
				grug_far = false,
				hop = false,
				leap = true,
				lspsaga = false,
				markview = false,
				['mini-tabline'] = true,
				['mini-icons'] = true,
				navic = false,
				neogit = false,
				notify = false,
				nvshades = false,
				orgmode = false,
				rainbowdelimiters = false,
				['render-markdown'] = true,
				semantic_tokens = false,
				['snacks-dashboard'] = false,
				['tiny-inline-diagnostic'] = false,
				todo = true,
				trouble = false,
				['vim-illuminate'] = false,
			},
		})

		base46.load((require('utils.colorscheme').variant or 'gruvchad'):gsub('base46%-', ''))

		local colors = base46.theme_tables[base46.current_theme]
		local hl = require('utils.highlight')

		hl.apply({
			basic = {
				ModeOther = { link = 'St_ConfirmMode' },
				ModeNormal = { link = 'St_NormalMode' },
				ModeInsert = { link = 'St_InsertMode' },
				ModeVisual = { link = 'St_VisualMode' },
				ModeCommand = { link = 'St_CommandMode' },
				ModeReplace = { link = 'St_ReplaceMode' },

				FloatTitle = {
					fg = colors.base_30.black,
					bg = colors.base_30.blue,
					bold = true,
				},
				FloatFooter = { link = 'FloatTitle' },

				SnacksIndent = { fg = colors.base_30.line },
				SnacksIndentScope = { fg = colors.base_30.teal },
			},
			extra = {
				hl.modify('NormalFloat', { fg = colors.base_30.white }),

				-- Syntax
				hl.modify('Keyword', { italic = true }),
				hl.modify('@keyword', { italic = true }),
				hl.modify('@keyword.return', { italic = true }),
				hl.modify('@keyword.function', { italic = true }),
				hl.modify('@keyword.operator', { italic = true }),
				hl.modify('@keyword.conditional', { italic = true }),
				hl.modify('@keyword.conditional.ternary', { italic = true }),
				hl.modify('Function', { bold = true }),
				hl.modify('@function', { bold = true }),
				hl.modify('@function.call', { bold = true }),
				hl.modify('@function.method', { bold = true }),
				hl.modify('@function.method.call', { bold = true }),
				hl.modify('Type', { bold = true }),
				hl.modify('Comment', { italic = true }),
				hl.modify('@comment', { italic = true }),
			},
		})
	end,
}
