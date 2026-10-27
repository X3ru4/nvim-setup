return {
	'romus204/tree-sitter-manager.nvim',
	event = 'VeryLazy',
	opts = {
		-- list of parsers to install automatically
		ensure_installed = {
			'c',
			'lua',
			'vim',
			'vimdoc',
			'query',
			'markdown',
			'markdown_inline',
		},
		auto_install = true,
		border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
		nerdfont = true,
		min_width = 40,
		min_height = 25,
	},
}
