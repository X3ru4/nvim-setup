return {
	'rebelot/kanagawa.nvim',
	name = 'kanagawa',
	config = function()
		require('kanagawa').setup({
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			theme = 'wave', -- Load "wave" theme
			background = { -- map the value of 'background' option to a theme
				dark = 'wave', -- try "dragon" !
				light = 'lotus',
			},
		})
		vim.cmd.colorscheme('kanagawa')
	end,
}
