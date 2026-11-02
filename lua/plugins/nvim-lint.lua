return {
	url = 'https://codeberg.org/mfussenegger/nvim-lint.git',
	event = 'BufReadPost',
	config = function()
		local lint = require('lint')
		lint.linters_by_ft = {
			markdown = { 'markdownlint' },
			-- lua = { 'luacheck' },
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
