return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	dependencies = { 'folke/persistence.nvim' },
	config = function()
		local dashboard = require('alpha.themes.dashboard')

		local function button(sc, txt, keybind, keybind_opts)
			local opts = {
				position = 'center',
				shortcut = sc,
				cursor = 3,
				width = math.min(vim.api.nvim_win_get_width(0) - 6, 40),
				align_shortcut = 'right',
				hl_shortcut = 'Keyword',
				keymap = { '', sc, keybind, keybind_opts },
			}
			return {
				type = 'button',
				val = txt,
				opts = opts,
				on_press = function()
					if type(keybind) == 'function' then
						keybind()
					else
						vim.api.nvim_feedkeys(vim.keycode(keybind), 'nx', false)
					end
				end,
			}
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
			button('e', '  Explore', '<cmd>Oil<cr>'),
			button('f', '  Search files', '<cmd>FzfLua files<cr>'),
			button('o', '  Frecency/MRU', '<cmd>FzfLua oldfiles<cr>'),
			button('r', '  Restore last session', require('persistence').load),
			button('q', '  Quit', '<cmd>qa<cr>'),
		}

		require('alpha').setup(dashboard.config)
	end,
}
