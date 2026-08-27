return {
	'mitander/flume.nvim',
	name = 'flume',
	config = function()
		require('flume').setup({ schema = 'mesa' })
	end,
}
