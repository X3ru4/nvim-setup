return {
	"romus204/tree-sitter-manager.nvim",
	event = "BufReadPre",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
			-- list of parsers to install automatically
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			},
			auto_install = false,
			nohighlight = {},
			border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
		})
	end,
}
