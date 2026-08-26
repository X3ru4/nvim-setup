local M = {}
local colorscheme = require('utils.colorscheme')

-- Run `:Themes` command to see all available themes
-- Add colorscheme in ~/.config/nvim/lua/plugins/colorscheme/ press `gf` to open
colorscheme.default = 'base46'
colorscheme.variant = 'base46-gruvbox_light'
colorscheme.install = {
	'base46',
	'catppuccin',
	-- 'gruvbox-material',
	-- 'onedark',
}

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
