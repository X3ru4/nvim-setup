return {

	{
		"kosayoda/nvim-lightbulb",
    enabled = false,
		event = "LspAttach",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = {
					enabled = true,
					updatetime = 200,
          -- events = { "CursorMoved", "CursorMovedI" }
				},
				sign = {
					enabled = false,
				},
				float = {
          text = "💡",
					enabled = true,
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
	},

	{
		"j-hui/fidget.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("fidget").setup({})
			vim.notify = require("fidget").notify
		end,
	},

	{
		"mfussenegger/nvim-lint",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "ruff" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
    enabled = false,
		event = "InsertEnter",
		opts = {
			bind = true,
			floating_window = false,
			handler_opts = {
				border = "rounded",
			},
			hint_prefix = "󰅟  ",
		},
	},

	{
		"smjonas/inc-rename.nvim",
		opts = {
			-- input_buffer_type = "dressing",
		},
		keys = {
			{ "grn", ":IncRename ", desc = "Rename" },
		},
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup()
		end,
	},

	{
		"b0o/schemastore.nvim",
		enabled = false,
		ft = { "json" },
	},
}
