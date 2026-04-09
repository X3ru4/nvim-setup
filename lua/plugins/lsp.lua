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
		event = "BufReadPre",
		config = function()
			local icons = require("config.icons").diagnostic
			local enable = vim.lsp.enable
			local config = vim.lsp.config
			local severity_icons = {
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warn,
				[vim.diagnostic.severity.INFO] = icons.Info,
				[vim.diagnostic.severity.HINT] = icons.Hint,
			}

			vim.diagnostic.config({
				virtual_text = {
					prefix = function(diagnostic)
						return severity_icons[diagnostic.severity]
					end,
					suffix = "",
				},
				underline = false,
				float = { source = "if_many" },
				update_in_insert = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warn,
						[vim.diagnostic.severity.INFO] = icons.Info,
						[vim.diagnostic.severity.HINT] = icons.Hint,
					},
				},
			})

			vim.lsp.inlay_hint.enable(false)
			config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						-- Set cargo features to automatically enable all features for completion
						cargo = {
							allFeatures = true,
							-- You can also specify a specific command for check on save, e.g.,
							-- command = "clippy", (instead of the default 'check')
						},
						-- Inlay hints are very useful for Rust
						inlayHints = {
							enable = true,
							-- Further options for hints can be found in the rust-analyzer docs
						},
					},
				},
			})
			config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			enable({ "rust_analyzer", "lua_ls" })
		end,
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
