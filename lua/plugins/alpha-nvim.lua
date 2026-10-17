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
			'███  ██ ▄▄▄▄▄  ▄▄▄  ▄▄ ▄▄ ▄▄ ▄▄   ▄▄',
			'██ ▀▄██ ██▄▄  ██▀██ ██▄██ ██ ██▀▄▀██',
			'██   ██ ██▄▄▄ ▀███▀  ▀█▀  ██ ██   ██',
			'',
			'Simplicity is the Ultimate Sophistication.',
		}

		local function new_file()
			vim.ui.input({ prompt = ' New file: ' }, function(input)
				if input then
					input = vim.trim(input)
					if #input > 0 then
						vim.cmd.edit(input)
					else
						vim.cmd.enew()
					end
				end
			end)
		end

		dashboard.section.buttons.val = {
			button('n', '  New file', new_file),
			button('e', '  Explore', '<Cmd>Oil<Cr>'),
			button('f', '  Search files', '<Cmd>FzfLua files<Cr>'),
			button('o', '  Frecency/MRU', '<Cmd>FzfLua oldfiles<Cr>'),
			button('r', '  Restore last session', require('persistence').load),
			button('q', '  Quit', '<Cmd>qa<Cr>'),
		}

		require('alpha').setup(dashboard.config)
	end,
}
