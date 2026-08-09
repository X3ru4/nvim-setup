return {
	'stevearc/oil.nvim',
	cmd = 'Oil',
	keys = {
		{ '<leader>e', '<cmd>Oil<cr>', desc = 'Open oil' },
		{ '<leader>i', '<cmd>Oil .<cr>', desc = 'Open oil home' },
		{ 'gf' },
	},
	config = function()
		local has_fzf, fzf = pcall(require, 'fzf-lua')
		local Oil = require('oil')

		function Oil.get_oil_winbar()
			local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
			local dir = Oil.get_current_dir(bufnr)
			if dir then
				return '%#TabLineSel#' .. vim.fn.fnamemodify(dir, ':~')
			else
				return vim.api.nvim_buf_get_name(0)
			end
		end

		Oil.setup({
			win_options = {
				winbar = '%!v:lua.require("oil").get_oil_winbar()',
			},
			-- preview_win = {
			-- 	win_options = {},
			-- },
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
				['<leader>ff'] = has_fzf and {
					function()
						fzf.files({ cwd = Oil.get_current_dir(0) })
					end,
					mode = 'n',
				},
				['<leader>fg'] = has_fzf and {
					function()
						fzf.live_grep({ cwd = Oil.get_current_dir(0) })
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
}
