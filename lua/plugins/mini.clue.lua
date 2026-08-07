return {
	'nvim-mini/mini.clue',
	event = 'VeryLazy',
	version = false,
	config = function()
		require('mini.clue').setup({
			triggers = {
				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },

				-- Built-in completion
				{ mode = 'i', keys = '<C-x>' },

				-- `g` key
				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },

				-- Marks
				{ mode = 'n', keys = '\'' },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = '\'' },
				{ mode = 'x', keys = '`' },

				-- Registers
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },

				-- Window commands
				{ mode = 'n', keys = '<C-w>' },

				-- `z` key
				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },

				-- [ and ]
				{ mode = 'n', keys = '[' },
				{ mode = 'x', keys = '[' },
				{ mode = 'n', keys = ']' },
				{ mode = 'x', keys = ']' },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				require('mini.clue').gen_clues.builtin_completion(),
				require('mini.clue').gen_clues.g(),
				require('mini.clue').gen_clues.marks(),
				require('mini.clue').gen_clues.registers(),
				require('mini.clue').gen_clues.windows(),
				require('mini.clue').gen_clues.z(),
			},

			-- Clue window settings
			window = {
				-- Floating window config
				config = {
					border = nil,
				},

				-- Delay before showing clue window
				delay = 200,

				-- Keys to scroll inside the clue window
				scroll_down = '<C-d>',
				scroll_up = '<C-u>',
			},
		})
	end,
}
