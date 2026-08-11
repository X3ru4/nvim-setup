return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	branch = 'main',
	event = 'VeryLazy',
	init = function()
		vim.g.no_plugin_maps = true
	end,
	config = function()
		require('nvim-treesitter-textobjects').setup({
			select = {
				lookahead = true,
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})

		local map = vim.keymap
		local mode = { 'n', 'x', 'o' }
		local ts_move = require('nvim-treesitter-textobjects.move')

		map.set(mode, '+m', function()
			ts_move.goto_next('@function.outer', 'textobjects')
		end)
		map.set(mode, '-m', function()
			ts_move.goto_previous('@function.outer', 'textobjects')
		end)

		map.set(mode, '+d', function()
			ts_move.goto_next('@conditional.outer', 'textobjects')
		end)
		map.set(mode, '-d', function()
			ts_move.goto_previous('@conditional.outer', 'textobjects')
		end)

		map.set(mode, '<PageUp>', function ()
			ts_move.goto_previous('@block.outer', 'textobjects')
		end)
		map.set(mode, '<PageDown>', function ()
			ts_move.goto_next('@block.outer', 'textobjects')
		end)

		local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
		map.set(mode, ';', ts_repeat_move.repeat_last_move_next)
		map.set(mode, ',', ts_repeat_move.repeat_last_move_previous)
	end,
}
