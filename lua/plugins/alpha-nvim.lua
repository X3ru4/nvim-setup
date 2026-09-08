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

		dashboard.section.header.val = {
			'╷ ╷╭─╮╭─╮╷ ╷╷ ╷',
			'╭┼╯╶─┤├┬╯│ │╰─┤',
			'╵ ╵╰─╯╵╰╴╰─╯  ╵',
		}
		dashboard.section.buttons.val = {
			button('e', '  New file', '<Cmd>ene <CR>'),
			button('f', '  Search files', '<Cmd>FzfLua files<Cr>'),
			button('o', '  Frecency/MRU', '<Cmd>FzfLua oldfiles<Cr>'),
			button('x', '  Explore', '<Cmd>Oil <CR>'),
			button('g', '  Grep', '<Cmd>FzfLua live_grep<Cr>'),
			button('c', '  Configs', '<Cmd>FzfLua files cwd=~/.config/nvim/<Cr>'),
			button('r', '  Open last session', function()
				require('persistence').load()
			end),
			button('q', '  Quit', '<Cmd>qa!<Cr>'),
		}

		require('alpha').setup(dashboard.config)

		dashboard.section.footer.opts.positon = 'center'
		dashboard.section.footer.val = {
			'Welcome back, boss!'
		}
	end,
}
