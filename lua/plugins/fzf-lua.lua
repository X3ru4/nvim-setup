return {
	'ibhagwan/fzf-lua',
	event = 'VeryLazy',
	config = function()
		require('fzf-lua').setup({
			'telescope',
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
				preview = {
					wrap = true,
					hidden = true,
				},
				height = 0.8,
				width = 0.85,
				backdrop = 100,
				treesitter = {
					enabled = false,
				},
				fullscreen = true,
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
					fullscreen = true,
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
						preview = { hidden = false },
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
		require('utils.keymap').set_list({
			{ 'n', '<leader>cs', fzf.spell_suggest, { desc = 'Spell suggest' } },
			{ 'n', '<leader>cq', fzf.quickfix, { desc = 'Quickfix' } },
			{ 'n', '<leader>cd', fzf.diagnostics_document, { desc = 'All diagnostics' } },
			{ 'n', '<leader>cc', fzf.colorschemes, { desc = 'Change colorscheme' } },
			{ 'n', '<leader>cgh', fzf.git_hunks, { desc = 'Git hunks' } },
			{ 'n', '<leader>cgd', fzf.git_diff, { desc = 'Git diff' } },
			{ 'n', '<leader>cgc', fzf.git_commits, { desc = 'Git commits' } },
			{ 'n', '<leader>fr', fzf.registers, { desc = 'FZF register' } },
			{ 'n', '<leader>ff', fzf.files, { desc = 'FZF file CWD' } },
			{
				'n',
				'<leader>fd',
				function()
					fzf.files({ cwd = vim.fn.expand('%:h') })
				end,
				{ desc = 'FZF config' },
			},
			{
				'n',
				'<leader>fc',
				function()
					fzf.files({ cwd = vim.fn.stdpath('config') })
				end,
				{ desc = 'FZF config' },
			},

			{ 'n', '<leader>fb', fzf.buffers, { desc = 'FZF buffers' } },
			{ 'n', '<leader>ft', fzf.tabs, { desc = 'FZF tabs' } },
			{ 'n', '<leader>fh', fzf.highlights, { desc = 'FZF highlights' } },
			{ 'n', '<leader>fo', fzf.oldfiles, { desc = 'FZF old files' } },
			{ 'n', '<leader>fT', fzf.filetypes, { desc = 'FZF filetypes' } },
			{ 'n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' } },
			{ 'n', '<leader>fu', fzf.builtin, { desc = 'FZF built-in' } },

			{ 'n', 'grd', fzf.lsp_definitions, { desc = 'LSP Definitions' } },
			{ 'n', 'gri', fzf.lsp_implementations, { desc = 'LSP Implementations' } },
			{ 'n', 'grr', fzf.lsp_references, { desc = 'LSP References' } },
			{ 'n', 'grt', fzf.lsp_typedefs, { desc = 'LSP Typedefs' } },
			{ 'n', '<leader>cl', fzf.lsp_document_symbols, { desc = 'LSP symbols' } },
		})

		local hl = require('utils.highlight')
		local fzf_hl = {
			FzfLuaNormal = { link = 'NormalFloat' },
			FzfLuaBorder = { link = 'FloatBorder' },
			FzfLuaTitle = { link = 'FloatTitle' },
			FzfLuaCursorLine = { fg = hl.getfg('Normal'), bg = hl.getbg('Visual') },
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
		}
		hl.add_callback('fzf-lua', function()
			hl.apply({ basic = fzf_hl })
		end)
	end,
}
