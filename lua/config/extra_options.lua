local M = {}

-- Run `:Themes` command to see all available themes
-- Add colorscheme in ~/.config/nvim/lua/plugins/colorscheme/ press `gf` to open
vimu.colorscheme.default = 'nvchad'

M.blinkcmp = {
	menu = {
		border = 'rounded',
	},
	documentation = {
		auto_show = false,
		border = 'rounded',
	},
	appearance = {
		use_nvimcmp_hl = false,
	},
}

return M
