return {
	"stevearc/conform.nvim",
	event = "LspAttach",
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "" },
			hpp = { "" },
			c = { "" },
			h = { "" },
		},
		default_format_opts = {
			lsp_format = "",
		},
		format_on_save = { timeout_ms = 500 },
		formatters = {
			shfmt = {
				append_args = { "-i", "2" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
