return {
	'X3ru4/terminil.nvim',
	event = 'VeryLazy',
	config = function()
		require('terminil').setup()
		local map = vim.keymap.set

		map('n', '<leader>to', function()
			tnil.termonly('hide')
		end)
		map('n', '<leader>tc', function()
			tnil.close()
		end)
		map('n', '<leader>th', function()
			tnil.hide()
		end)
		map('n', '<leader>tm', function()
			tnil.open_multiple()
		end)
		map('n', '<leader>ts', function()
			local behaviors = {
				'open',
				'close',
				'switch',
			}
			tnil.select(behaviors[vim.v.count1])
		end)
		map('n', '<leader>ta', function()
			tnil.add()
		end)
		map('n', '<leader>ty', function()
			tnil.switch(1)
		end)
		map('n', '<leader>tr', function()
			tnil.switch(-1)
		end)
	end,
}
