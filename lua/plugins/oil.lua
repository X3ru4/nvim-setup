return {
	'stevearc/oil.nvim',
	cmd = 'Oil',
	keys = {
		{ '<leader>e', '<cmd>Oil<cr>', desc = 'Open oil' },
		{ '<leader>i', '<cmd>Oil .<cr>', desc = 'Open oil home' },
		'gf',
	},
	config = function()
		local fzf = require('fzf-lua')
		local Oil = require('oil')

		function Oil.get_winbar()
			local bufnr = vim.api.nvim_get_current_buf()
			local dir = Oil.get_current_dir(bufnr)
			if dir then
				return '%#Function#' .. vim.fn.fnamemodify(dir, ':~')
			else
				return '%#Function#Unknown'
			end
		end

		local prompt = ' Open: '
		local special_dir = {
			termux = '~/.termux/',
			fish = '~/.config/fish/',
			plugin = '~/.local/share/nvim/site/pack/core/opt/',
		}

		local function advance_open()
			vim.ui.input({ prompt = prompt, default = '' }, function(input)
				if input then
					if input:sub(1, 1) == '@' then
						local what = input:sub(2)
						local dir = special_dir[what]
						if dir then
							Oil.open(dir)
						else
							local ok, stdpath = pcall(vim.fn.stdpath, what)
							if ok and type(stdpath) == 'string' then
								Oil.open(stdpath)
							else
								vim.notify('Where "' .. what .. '"?' , vim.log.levels.INFO, { title = 'oil.nvim', icon = '󰏇 ' })
							end
						end
					else
						Oil.open(input)
					end
				end
			end)
		end

		local function root_open()
			vim.ui.input({ prompt = prompt, default = '~/' }, function(input)
				if input then
					Oil.open(input)
				end
			end)
		end

		Oil.setup({
			win_options = {
				winbar = '%!v:lua.require("oil").get_winbar()',
			},
			confirmation = {
				border = nil,
				win_options = {},
			},
			progress = {
				border = nil,
				win_options = {},
			},
			delete_to_trash = false,
			use_default_keymaps = false,
			keymaps = {
				['<C-j>'] = { 'actions.select', opts = { vertical = true } },
				['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
				['<C-t>'] = { 'actions.select', opts = { tab = true } },
				['<C-p>'] = 'actions.preview',
				['<C-l>'] = 'actions.refresh',
				['<CR>'] = 'actions.select',
				['<BS>'] = { 'actions.parent', mode = 'n' },
				['_'] = { 'actions.open_cwd', mode = 'n' },
				['q'] = { 'actions.close', mode = 'n' },
				['.'] = { 'actions.toggle_hidden', mode = 'n' },
				['g?'] = { 'actions.show_help', mode = 'n' },
				['gs'] = { 'actions.change_sort', mode = 'n' },
				['gx'] = 'actions.open_external',
				['gw'] = {
					advance_open,
					mode = 'n',
				},
				['gf'] = {
					root_open,
					mode = 'n',
				},
				['<leader>ff'] = {
					function()
						fzf.files({ cwd = Oil.get_current_dir(0) })
					end,
					mode = 'n',
				},
				['<leader>fg'] = {
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
