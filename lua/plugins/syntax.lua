return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"MeanderingProgrammer/treesitter-modules.nvim",
				---@module 'treesitter-modules'
				---@type ts.mod.UserConfig
				opts = {
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<C-Space>", -- keymap to start the selection
							node_incremental = "<C-Space>", -- keymap to increment the selection
							scope_incremental = false, -- keymap to increment to the next scope
							node_decremental = "<BS>", -- keymap to decrement the selection
						},
					},
				},
			},
		},
		config = function()
			require("nvim-treesitter.config").setup({
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

	{
		"utilyre/sentiment.nvim",
		enabled = false,
		version = "*",
		event = "VeryLazy",
		opts = {
			pairs = {
				{ "(", ")" },
				{ "{", "}" },
				{ "[", "]" },
			},
		},
	},
}
