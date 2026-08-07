local M = {}

-- Run `:Themes` command to see all available themes
-- Add colorscheme in ~/.config/nvim/lua/plugins/colorscheme/ press `gf` to open
vimu.colorscheme.default = 'base46'
vimu.colorscheme.variant = 'base46-gruvbox_light'

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
