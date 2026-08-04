return {
	'stevearc/oil.nvim',
	cmd = 'Oil',
	dependencies = {
		{
			enabled = true,
			'malewicz1337/oil-git.nvim',
			config = function()
				require('oil-git').setup({
					symbols = {
						file = {
							added = ' ',
							modified = ' ',
							renamed = ' ',
							deleted = ' ',
							copied = ' ',
							conflict = ' ',
							untracked = ' ',
							ignored = ' ',
						},
						directory = {
							added = ' ',
							modified = ' ',
							renamed = ' ',
							deleted = ' ',
							copied = ' ',
							conflict = ' ',
							untracked = ' ',
							ignored = ' ',
						},
					},
					highlights = {
						OilGitAdded = { link = 'Added' },
						OilGitModified = { link = 'Changed' },
						OilGitRenamed = { link = 'Changed' },
						OilGitDeleted = { link = 'Removed' },
						OilGitCopied = { link = 'DiagnosticHint' },
						OilGitConflict = { link = 'DiagnosticInfo' },
						OilGitUntracked = { link = 'DiagnosticInfo' },
						OilGitIgnored = { link = 'DiagnosticInfo' },
					},
				})
			end,
		},
	},
	config = function()
		local fzf = require('fzf-lua')
		local current_dir = require('oil').get_current_dir

		function _G.get_oil_winbar()
			local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
			local dir = require('oil').get_current_dir(bufnr)
			if dir then
				return '%#TabLineSel#' .. vim.fn.fnamemodify(dir, ':~')
			else
				return vim.api.nvim_buf_get_name(0)
			end
		end

		require('oil').setup({
			win_options = {
				winbar = '%!v:lua.get_oil_winbar()',
			},
			preview_win = {
				win_options = {},
			},
			confirmation = {
				border = 'rounded',
				win_options = {},
			},
			progress = {
				border = 'rounded',
				win_options = {},
			},
			delete_to_trash = false,
			use_default_keymaps = true,
			keymaps = {
				['<C-s>'] = false,
				['<C-h>'] = false,
				['g.'] = false,
				['-'] = false,
				['<leader>ff'] = {
					function()
						fzf.files({
							cwd = current_dir(0),
						})
					end,
					mode = 'n',
				},
				['<leader>fg'] = {
					function()
						fzf.live_grep({
							cwd = current_dir(0),
						})
					end,
					mode = 'n',
				},
				['<bs>'] = { 'actions.parent', mode = 'n' },
				['.'] = { 'actions.toggle_hidden', mode = 'n' },
				['q'] = { 'actions.close', mode = 'n' },
				['gc'] = {
					function()
						vim.ui.input({ prompt = 'Search  ', default = './' }, function(input)
							if input then
								vim.cmd('Oil ' .. input)
							end
						end)
					end,
					mode = 'n',
				},
				['gf'] = {
					function()
						vim.ui.input({ prompt = 'Search  ', default = '~/' }, function(input)
							if input then
								vim.cmd('Oil ' .. input)
							end
						end)
					end,
					mode = 'n',
				},
			},
			columns = {
				-- "permissions",
				'size',
				'icon',
				-- "mtime",
			},
		})
	end,
	keys = {
		{ '<leader>e', '<cmd>Oil<cr>', desc = 'Open oil' },
		{ '<leader>i', '<cmd>Oil .<cr>', desc = 'Open oil home' },
		{ 'gf' },
	},
}
