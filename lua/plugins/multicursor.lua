return {
	'jake-stewart/multicursor.nvim',
	branch = '1.0',
	keys = {
		{ mode = { 'n', 'x' }, '<leader>n' },
		{ mode = { 'n', 'x' }, '<leader>N' },
		{ mode = { 'n', 'x' }, '<leader>a' },
		{ mode = { 'n', 'x' }, '<leader>j' },
		{ mode = { 'n', 'x' }, '<C-down>' },
		{ mode = { 'n', 'x' }, '<C-up>' },
	},
	config = function()
		local mc = require('multicursor-nvim')

		mc.setup()

		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
			layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

			-- Delete the main cursor.
			layerSet({ 'n', 'x' }, '<leader>d', mc.deleteCursor)

			-- Enable and clear cursors using escape.
			layerSet('n', '<esc>', function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look.
		require('utils.highlight').apply({
			basic = {
				MultiCursorCursor = { link = 'Cursor' },
				MultiCursorVisual = { link = 'Visual' },
				MultiCursorSign = { link = 'SignColumn' },
				MultiCursorMatchPreview = { link = 'Search' },
				MultiCursorDisabledCursor = { reverse = true },
				MultiCursorDisabledVisual = { link = 'Visual' },
				MultiCursorDisabledSign = { link = 'SignColumn' },
			},
		})

		local mode = { 'n', 'x' }
		local map = vim.keymap
		map.set(mode, '<C-Up>', function()
			mc.lineAddCursor(-1)
		end)
		map.set(mode, '<C-Down>', function()
			mc.lineAddCursor(1)
		end)
		map.set(mode, '<leader><up>', function()
			mc.lineSkipCursor(-1)
		end)
		map.set(mode, '<leader><down>', function()
			mc.lineSkipCursor(1)
		end)

		-- Add or skip adding a new cursor by matching word/selection
		map.set(mode, '<leader>n', function()
			mc.matchAddCursor(1)
		end)
		map.set(mode, '<leader>N', function()
			mc.matchAddCursor(-1)
		end)
		map.set(mode, '<leader>x', function()
			mc.matchSkipCursor(1)
		end)
		map.set(mode, '<leader>X', mc.matchSkipCursor)
		map.set(mode, '<leader>a', mc.matchAllAddCursors)
		map.set(mode, '<leader>j', mc.addCursor)
	end,
}
