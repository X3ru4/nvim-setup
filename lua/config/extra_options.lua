local M = {}
local colorscheme = require('utils.colorscheme')

-- Add colorscheme in ~/.config/nvim/lua/plugins/colorscheme/ press `gf` to open
colorscheme.default = 'base46'
colorscheme.variant = 'base46-gruvbox_light'
colorscheme.install = {
	'base46',
	'ember_theme', -- It is the file name
}

-- Quick configuration for blink.cmp
M.blinkcmp = {
	menu = {
		border = nil,
	},
	documentation = {
		auto_show = false,
		border = nil,
	},
	appearance = {
		use_nvimcmp_hl = false,
	},
}

return M
