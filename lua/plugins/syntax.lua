return {

	{
		"romus204/tree-sitter-manager.nvim",
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
				-- Optional: custom paths
				-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
				-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
			})
		end,
	},

	{
		"andymass/vim-matchup",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("match-up").setup({
				text_obj = { enabled = 0 },
				motion = { enabled = 0 },
				matchparen = {
					enabled = 1,
					offscreen = {
						method = "popup",
					},
				},
				treesitter = {
					enabled = true,
					stopline = 500,
					disable_virtual_text = true,
				},
			})
		end,
	},
}
