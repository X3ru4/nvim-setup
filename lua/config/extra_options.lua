local M = {}

-- Run `:Themes` command to see all available themes
-- Add colorscheme in ~/.config/nvim/lua/plugins/colorscheme/ press `gf` to open
vimu.colorscheme.default = "gruvbox-material"

M.blinkcmp = {
	menu = {
		border = "none",
	},
	documentation = {
		auto_show = false,
		border = "solid",
	},
	appearance = {
		use_nvimcmp_hl = false,
	},
}

M.statusline = {
	separator = { "", "" },
}

return M
