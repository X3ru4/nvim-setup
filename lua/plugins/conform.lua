return {
	'stevearc/conform.nvim',
	cmd = 'ConformInfo',
	opts = {
		formatters_by_ft = {
			lua = { 'stylua' },
			json = { 'prettier' },
			markdown = { 'prettier' },
			python = { 'ruff' },
			rust = { 'rustfmt' },
		},
		formatters = {
			ruff = {
				command = 'ruff',
				args = { 'format', '-' },
				stdin = true,
			},
			prettier = {
				prepend_args = {},
			},
		},
		default_format_opts = {
			lsp_format = 'fallback',
		},
		-- Use the "*" filetype to run formatters on all filetypes.
		['*'] = { 'codespell' },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		['_'] = { 'trim_whitespace' },
		format_on_save = false,
	},
	init = function()
		vim.o.formatexpr = [[v:lua.require'conform'.formatexpr()]]
	end,
	keys = {
		{
			'<leader>cf',
			function()
				require('conform').format({ async = true, lsp_fallback = true }, function(err, _)
					if not err then
						local mode = vim.api.nvim_get_mode().mode
						if vim.startswith(mode:lower(), 'v') then
							vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nx', false)
						end
					end
				end)
			end,
			desc = 'Format code',
			mode = { 'n', 'x' },
		},
	},
}
