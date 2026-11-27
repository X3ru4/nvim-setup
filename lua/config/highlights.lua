local hl = require('utils.highlight')

-- These aliases are primarily used for heirline.nvim and fzf-lua
hl.variables.White = hl.getfg('Normal') or hl.getfg('@text')
hl.variables.Black = hl.getbg('Normal') or hl.getbg('StatusLine')

hl.variables.Black1 = hl.blend(hl.variables.Black, hl.variables.White, 0.9)
hl.variables.Black2 = hl.blend(hl.variables.Black, hl.variables.White, 0.8)
hl.variables.Black3 = hl.blend(hl.variables.Black, hl.variables.White, 0.7)
hl.variables.Black4 = hl.blend(hl.variables.Black, hl.variables.White, 0.6)

hl.apply({
	Yank = {
		bg = hl.blend(hl.getfg('Constant'), hl.variables.Black, 0.25),
	},
	Paste = {
		bg = hl.blend(hl.getfg('Added'), hl.variables.Black, 0.3),
	},
	MCursor = { link = 'Cursor' },

	-- Modify default highlights.
	hl.modify('Visual', { bold = false }),
	hl.modify('FloatBorder', { bg = hl.getbg('NormalFloat') }),
})
hl.run_hooks()
