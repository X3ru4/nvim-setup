return {

	{
		"romus204/tree-sitter-manager.nvim",
		event = "BufReadPost",
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
				border = "rounded", -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
			})
		end,
	},

	{
		"andymass/vim-matchup",
		event = { "BufReadPre", "BufNewFile" },
		---@type matchup.Config
		opts = {
			text_obj = { enabled = 0 },
			motion = { enabled = 0 },
      mappings = { enabled = 0 },
      matchpref = { enabled = 0 },
      mouse = { enabled = 0 },
      surround = { enabled = 0 },
			matchparen = {
				enabled = 1,
				offscreen = {
					method = "",
					syntax_hl = 0,
				},
			},
			treesitter = {
				enabled = true,
				stopline = 500,
				disable_virtual_text = true,
			},
		},
	},
}
