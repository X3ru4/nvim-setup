local M = {}
local colorscheme = require('utils.colorscheme')

-- Add colorscheme in ~/.config/nvim/lua/plugins/colorscheme/ press `gf` to open
colorscheme.default = 'ember'
colorscheme.variant = 'ember-light'
colorscheme.install = {
	'base46',
	'ember_theme', -- It is the file name
}

-- Quick configuration for blink.cmp
M.blinkcmp = {
	menu = {
		border = 'none',
	},
	documentation = {
		auto_show = false,
		border = 'none',
	},
	appearance = {
		use_nvimcmp_hl = false,
	},
}

return M
