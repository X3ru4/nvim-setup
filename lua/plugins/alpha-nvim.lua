return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	dependencies = { 'folke/persistence.nvim' },
	config = function()
		local dashboard = require('alpha.themes.dashboard')
		-- Modify the button width.
		local button = function(sc, txt, keybind, keybind_opts)
			local btn = dashboard.button(sc, txt, keybind, keybind_opts)
			local width = vim.api.nvim_win_get_width(0)
			btn.opts.width = math.min(width - 6, 40)
			return btn
		end

		-- Create your own on https://patorjk.com/software/taag/#p=display&f=ANSI+Compact&t=X3ru4
		dashboard.section.header.val = {
			'██  ██ ████▄ ▄▄▄▄  ▄▄ ▄▄ ██  ██',
			' ████   ▄▄██ ██▄█▄ ██ ██ ▀█████',
			'██  ██ ▄▄▄█▀ ██ ██ ▀███▀     ██',
		}
		dashboard.section.buttons.val = {
			button('e', '󰝒  New file', '<cmd>ene <CR>'),
			button('f', '󰱼  Search files', [[<cmd>lua require('fzf-lua').files()<cr>]]),
			button('o', '󱋡  Frecency/MRU', [[<cmd>lua require('fzf-lua').oldfiles()<cr>]]),
			button('x', '󰥨  Explore', '<cmd>Oil <CR>'),
			button('g', '󰺯  Grep', [[<cmd>lua require('fzf-lua').live_grep()<cr>]]),
			button('c', '󰒓  Configs', [[<cmd>lua require('fzf-lua').files({ cwd = "~/.config/nvim", })<cr>]]),
			button('r', '󰮳  Open last session', '<cmd>lua require(\'persistence\').load()<cr>'),
			button('q', '󰈆  Quit', '<cmd>qa!<cr>'),
		}

		require('alpha').setup(dashboard.config)

		local stats = require('lazy').stats()

		dashboard.section.footer.opts.positon = 'center'
		vim.api.nvim_create_autocmd('UIEnter', {
			once = true,
			callback = function()
				dashboard.section.footer.val = {
					'Loaded '
						.. stats.loaded
						.. '/'
						.. stats.count
						.. ' plugins in '
						.. (math.floor(stats.startuptime * 100) / 100)
						.. 'ms',
				}
				vim.cmd('AlphaRedraw')
			end,
		})
	end,
}
