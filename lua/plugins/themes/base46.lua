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
			nvchad = {
				---@type 'default'|'atom'|'atom_colored'|'flat_light'|'flat_dark'
				cmp_style = 'flat_dark',
			},
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

		local variant = require('utils.colorscheme').variant
		if variant then
			base46.load(variant:gsub('^base46%-', ''))
		else
			base46.load('gruvchad')
		end

		local hl = require('utils.highlight')
		local function is_base46()
			local start = vim.g.colors_name:find('base46-', 0, true)
			return start
		end

		-- It will load if you change the colorscheme.
		hl.add_hook('base46', function()
			local colors = base46.theme_tables[base46.current_theme]

			hl.apply({
				basic = {
					ModeOther = { link = 'St_ConfirmMode', cforce = true },
					ModeNormal = { link = 'St_NormalMode', cforce = true },
					ModeInsert = { link = 'St_InsertMode', cforce = true },
					ModeVisual = { link = 'St_VisualMode', cforce = true },
					ModeCommand = { link = 'St_CommandMode', cforce = true },
					ModeReplace = { link = 'St_ReplaceMode', cforce = true },

					FloatTitle = {
						fg = colors.base_30.black,
						bg = colors.base_30.blue,
						bold = true,
					},
					FloatFooter = { link = 'FloatTitle' },

					MiniIndentscopeSymbol = { fg = colors.base_30.teal },
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
		end, false, is_base46)
	end,
}
