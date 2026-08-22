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

		local function cwd_open()
			vim.ui.input({ prompt = '  Open ', default = '' }, function(input)
				if input then
					Oil.open(input)
				end
			end)
		end

		local function root_open()
			vim.ui.input({ prompt = '  Open ', default = '~/' }, function(input)
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
        ["gs"] = { "actions.change_sort", mode = "n" },
				['gx'] = 'actions.open_external',
				['gc'] = {
					cwd_open,
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
