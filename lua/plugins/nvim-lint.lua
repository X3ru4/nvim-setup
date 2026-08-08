return {
	url = 'https://codeberg.org/mfussenegger/nvim-lint.git',
	event = 'BufReadPost',
	config = function()
		require('lint').linters_by_ft = {
			markdown = { 'markdownlint' },
			lua = { 'luacheck' },
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				require('lint').try_lint()
			end,
		})
	end,
}
