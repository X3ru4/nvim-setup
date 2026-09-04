return {
	'ibhagwan/fzf-lua',
	event = 'VeryLazy',
	config = function()
		require('fzf-lua').setup({
			ui_select = {},
			file_icon_padding = ' ',
			defaults = {
				prompt = '  ',
			},
			keymap = {
				builtin = {
					-- Only valid with the 'builtin' previewer
					['<C-w>'] = 'toggle-preview-wrap',
					['<C-p>'] = 'toggle-preview',
				},
			},
			winopts = {
				border = vim.o.winborder,
				preview = {
					wrap = true,
					hidden = true,
					border = vim.o.winborder,
				},
				height = 0.8,
				width = 0.8,
				backdrop = 100,
				treesitter = {
					enabled = false,
				},
				fullscreen = false,
			},
			fzf_opts = {
				['--pointer'] = '›',
				['--gutter'] = ' ',
				['--marker'] = '•',
				['--ellipsis'] = '~',
			},
			fzf_colors = { true },
			colorschemes = {
				winopts = {
					fullscreen = false,
					width = 0.8,
					height = 0.8,
				},
			},
			awesome_colorschemes = {
				winopts = {
					fullscreen = true,
				},
			},
			files = {
				winopts = {
					fullscreen = true,
				},
			},
			registers = {
				winopts = {
					preview = { hidden = false },
					fullscreen = true,
				},
			},
			buffers = {
				filename_only = true,
				winopts = {
					preview = { hidden = false },
					fullscreen = true,
				},
			},
			tabs = {
				winopts = {
					preview = { hidden = false },
					fullscreen = true,
				},
			},
			highlights = {
				winopts = {
					preview = { hidden = false },
					fullscreen = true,
				},
			},
			diagnostics = {
				winopts = {
					preview = { hidden = false },
				},
			},
			oldfiles = {
				cwd_only = true,
				winopts = {
					fullscreen = true,
				},
			},
			grep = {
				winopts = {
					preview = { hidden = false },
					fullscreen = true,
				},
			},
			lsp = {
				symbols = {
					locate = true,
					symbol_style = 3,
				},
			},
			git = {
				files = {
					winopts = {
						fullscreen = true,
					},
				},
				status = {
					winopts = {
						fullscreen = true,
					},
				},
				commits = {
					winopts = {
						fullscreen = true,
					},
				},
				bcommits = {
					winopts = {
						fullscreen = true,
					},
				},
				blame = {
					winopts = {
						fullscreen = true,
					},
				},
				branches = {
					winopts = {
						fullscreen = true,
					},
				},
				tags = {
					winopts = {
						fullscreen = true,
					},
				},
				stash = {
					winopts = {
						fullscreen = true,
					},
				},
				diff = {
					winopts = {
						preview = {
							hidden = false,
							border = 'none',
						},
						fullscreen = true,
					},
				},
				hunks = {
					winopts = {
						preview = { hidden = false },
						fullscreen = true,
					},
				},
				icons = {
					['M'] = { icon = '*', color = 'yellow' },
					['D'] = { icon = '-', color = 'red' },
					['A'] = { icon = '+', color = 'green' },
					['R'] = { icon = '~', color = 'yellow' },
					['C'] = { icon = '@', color = 'yellow' },
					['T'] = { icon = '!', color = 'magenta' },
					['?'] = { icon = '?', color = 'magenta' },
				},
			},
			quickfix = {
				winopts = {
					preview = { hidden = false },
					fullscreen = true,
				},
			},
		})

		local fzf = require('fzf-lua')
		local map = vim.keymap
		map.set('n', '<leader>cs', fzf.spell_suggest, { desc = 'Spell suggest' })
		map.set('n', '<leader>cq', fzf.quickfix, { desc = 'Quickfix' })
		map.set('n', '<leader>cd', fzf.diagnostics_document, { desc = 'All diagnostics' })
		map.set('n', '<leader>cc', fzf.colorschemes, { desc = 'Change colorscheme' })
		map.set('n', '<leader>cgh', fzf.git_hunks, { desc = 'Git hunks' })
		map.set('n', '<leader>cgd', fzf.git_diff, { desc = 'Git diff' })
		map.set('n', '<leader>cgc', fzf.git_commits, { desc = 'Git commits' })
		map.set('n', '<leader>fr', fzf.registers, { desc = 'FZF register' })
		map.set('n', '<leader>ff', fzf.files, { desc = 'FZF file CWD' })
		map.set('n', '<leader>fd', function()
			fzf.files({ cwd = vim.fn.expand('%:h') })
		end, { desc = 'FZF parent' })
		map.set('n', '<leader>fc', function()
			fzf.files({ cwd = vim.fn.stdpath('config') })
		end, { desc = 'FZF config' })

		map.set('n', '<leader>fb', fzf.buffers, { desc = 'FZF buffers' })
		map.set('n', '<leader>ft', fzf.tabs, { desc = 'FZF tabs' })
		map.set('n', '<leader>fh', fzf.highlights, { desc = 'FZF highlights' })
		map.set('n', '<leader>fo', fzf.oldfiles, { desc = 'FZF old files' })
		map.set('n', '<leader>fT', fzf.filetypes, { desc = 'FZF filetypes' })
		map.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' })
		map.set('n', '<leader>fu', fzf.builtin, { desc = 'FZF built-in' })

		map.set('n', 'grd', fzf.lsp_definitions, { desc = 'LSP Definitions' })
		map.set('n', 'gri', fzf.lsp_implementations, { desc = 'LSP Implementations' })
		map.set('n', 'grr', fzf.lsp_references, { desc = 'LSP References' })
		map.set('n', 'grt', fzf.lsp_typedefs, { desc = 'LSP Typedefs' })
		map.set('n', '<leader>cl', fzf.lsp_document_symbols, { desc = 'LSP symbols' })

		local hl = require('utils.highlight')
		local fzf_hl = {
			FzfLuaNormal = { link = 'NormalFloat' },
			FzfLuaBorder = { link = 'FloatBorder' },
			FzfLuaTitle = { fg = hl.alias.Black, bg = hl.getfg('Removed'), bold = true },
			FzfLuaCursorLine = { bold = true, bg = hl.getbg('CursorLine') },
			FzfLuaTabMarker = { link = 'Structure' },
			FzfLuaHeaderBind = { link = 'FzfLuaTabMarker' },
			FzfLuaHeaderText = { link = 'Define' },
			FzfLuaBufFlagCur = { link = 'Typedef' },
			FzfLuaBufFlagAlt = { link = 'Tag' },
			FzfLuaPathColNr = { link = 'Question' },
			FzfLuaPathLineNr = { link = 'Character' },
			FzfLuaBufNr = { link = 'FzfLuaPathColNr' },
			FzfLuaLivePrompt = { link = 'FzfLuaNormal' },
			FzfLuaLiveSym = { link = 'FzfLuaNormal' },
			FzfLuaFzfPointer = { link = 'Keyword' },
			FzfLuaFzfHeader = { link = 'LineNr' },
			FzfLuaFzfPrompt = { link = 'MoreMsg' },
			FzfLuaFzfMatch = { fg = hl.getfg('Directory'), bold = true },

			FzfLuaPreviewNormal = { link = 'Normal' },
			FzfLuaPreviewBorder = { link = 'Normal' },
			FzfLuaPreviewTitle = { fg = hl.alias.Black, bg = hl.getfg('Added'), bold = true },
		}
		hl.add_hook('fzf-lua', function()
			hl.apply({ basic = fzf_hl })
		end, true)
	end,
}
