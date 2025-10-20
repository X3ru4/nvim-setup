return {

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang-format" },
				hpp = { "clang-format" },
				c = { "clang-format" },
				h = { "clang-format" },
				json = { "clang-format" },
				python = { "ruff" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = false,
			formatters = {
				shfmt = {
					append_args = { "-i", "2" },
				},
				ruff = {
					command = "ruff",
					args = { "format", "-" },
					stdin = true,
				},
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = false, lsp_fallback = true })
					vim.cmd("silent! w")
				end,
				desc = "Format and save file",
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
