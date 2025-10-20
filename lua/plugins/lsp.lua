return {

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.lsp.inlay_hint.enable(true)
			local server = {
				-- Lua
				lua_ls = {},
				-- -- C/C++
				-- clangd = {},
				-- Python
				basedpyright = {},
			}

			for name, opts in pairs(server) do
				vim.lsp.config(name, opts)
				vim.lsp.enable(name)
			end
		end,
	},

	{
		enabled = false,
		"j-hui/fidget.nvim",
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
		enabled = false,
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			floating_window = false,
			handler_opts = {
				border = "rounded",
			},
			hint_prefix = "🧠",
		},
	},

	{
		"smjonas/inc-rename.nvim",
		opts = {
			input_buffer_type = "dressing",
		},
		keys = {
			{ "grn", ":IncRename ", desc = "Rename" },
		},
	},
}
