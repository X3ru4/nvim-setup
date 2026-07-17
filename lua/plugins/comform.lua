return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "clang-format" },
			hpp = { "clang-format" },
			c = { "clang-format" },
			h = { "clang-format" },
			json = { "prettier" },
			python = { "ruff" },
			rust = { "rustfmt" },
		},
		formatters = {
			ruff = {
				command = "ruff",
				args = { "format", "-" },
				stdin = true,
			},
			prettier = {
				prepend_args = { "--tab-width", "2" },
			},
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Use the "*" filetype to run formatters on all filetypes.
		["*"] = { "codespell" },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
		format_on_save = false,
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = false, lsp_fallback = true })
				vim.cmd("silent! w")
			end,
			desc = "Format and save file",
			mode = { "x", "n", "v" },
		},
	},
}
