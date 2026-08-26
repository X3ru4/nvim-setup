return {
	'Aejkatappaja/cendre',
	name = 'cendre',
	config = function()
		require('cendre').setup({
			background = 'hard', -- "hard" | "medium" | "soft"
			italic_virtual_text = false,
		})
		vim.cmd.colorscheme('cendre')
	end,
}
