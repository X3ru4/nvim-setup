return {
	url = 'https://codeberg.org/andyg/leap.nvim',
	event = 'VeryLazy',
	config = function()
		local map = vim.keymap.set
		map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
		-- map('n', 'S', '<Plug>(leap-from-window)')
		map({ 'o' }, 'R', '<Plug>(leap-remote-line)')
		map({ 'x', 'o' }, 'an', function()
			require('leap.treesitter').select({
				opts = require('leap.user').with_traversal_keys('n', 'N'),
			})
		end)
	end,
}
