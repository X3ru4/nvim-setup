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

		local function ft(kwargs)
			require('leap').leap(vim.tbl_deep_extend('keep', kwargs, {
				inputlen = 1,
				inclusive = true,
				opts = {
					-- Force autojump.
					labels = '',
					-- Match the modes where you don't need labels (`:h mode()`).
					safe_labels = vim.fn.mode(1):match('no?') and '' or nil,
				},
			}))
		end

		-- A helper function making it easier to set "clever-f" behavior
		-- (using f/F or t/T instead of ;/, - see the plugin clever-f.vim).
		local clever = require('leap.user').with_traversal_keys
		local clever_f, clever_t = clever('f', 'F'), clever('t', 'T')

		map({ 'n', 'x', 'o' }, 'f', function()
			ft({ opts = clever_f })
		end)
		map({ 'n', 'x', 'o' }, 'F', function()
			ft({ backward = true, opts = clever_f })
		end)
		map({ 'n', 'x', 'o' }, 't', function()
			ft({ offset = -1, opts = clever_t })
		end)
		map({ 'n', 'x', 'o' }, 'T', function()
			ft({ backward = true, offset = 1, opts = clever_t })
		end)
	end,
}
