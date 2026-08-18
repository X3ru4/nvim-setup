return {
	'kungfusheep/snipe-spell.nvim',
	enabled = false,
	dependencies = 'leath-dub/snipe.nvim',
	init = function()
		vim.opt.spell = true
	end,
	config = true,
	keys = {
		{ '<leader>fs', '<cmd>SnipeSpell <cr>', desc = 'Snipe Spellchecker' },
	},
}
