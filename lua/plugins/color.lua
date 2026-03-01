return {

	{
		"catgoose/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		keys = {
			{ "<leader>cC", "<cmd>ColorizerToggle<cr>", desc = "ColorizerToggle" },
		},
		opts = {
			---@type table
			options = {
				parsers = {
					css = false, -- preset: enables names, hex, rgb, hsl, oklch
					css_fn = false,
					tailwind = { enable = true },
					names = { enable = false },
					rgb = { enable = false },
					hsl = { enable = false },
					oklch = { enable = false },
					xterm = { enable = true },
					hex = {
						enable = true,
						rgb = false,
						rgba = false,
						rrggbb = true,
						rrggbbaa = true,
						aarrggbb = false,
					},
				},
				display = {
					mode = "virtualtext",
					virtualtext = {
            char = "",
						position = "before",
            hl_mode = "foreground"
					},
				},
			},
		},
	},
}
