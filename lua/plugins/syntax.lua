return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.config").setup({
        install_dir = "",
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				auto_install = true,
				ignore_install = { "javascript" },
				indent = { enable = true },
				highlight = {
					enable = true,
					-- disable = { "c", "rust" },
					additional_vim_regex_highlighting = false,
				},
				folds = {
					enable = true,
				},
			})

      local keymap = vim.keymap.set
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
