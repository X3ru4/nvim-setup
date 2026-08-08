return {
	'jake-stewart/multicursor.nvim',
	event = 'VeryLazy',
	branch = '1.0',
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
		require('utils.keymap').set_list({
			{
				mode,
				'<C-Up>',
				function()
					mc.lineAddCursor(-1)
				end,
			},
			{
				mode,
				'<C-Down>',
				function()
					mc.lineAddCursor(1)
				end,
			},
			{
				mode,
				'<leader><up>',
				function()
					mc.lineSkipCursor(-1)
				end,
			},
			{
				mode,
				'<leader><down>',
				function()
					mc.lineSkipCursor(1)
				end,
			},

			-- Add or skip adding a new cursor by matching word/selection
			{
				mode,
				'<leader>n',
				function()
					mc.matchAddCursor(1)
				end,
			},
			{
				mode,
				'<leader>N',
				function()
					mc.matchAddCursor(-1)
				end,
			},
			{
				mode,
				'<leader>x',
				function()
					mc.matchSkipCursor(1)
				end,
			},
			{
				mode,
				'<leader>X',
				mc.matchSkipCursor,
			},
			{
				mode,
				'<leader>a',
				mc.matchAllAddCursors,
			},
			{
				mode,
				'<leader>j',
				mc.addCursor,
			},
		})
	end,
}
