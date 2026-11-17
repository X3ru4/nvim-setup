return {
	url = 'https://codeberg.org/mfussenegger/nvim-lint.git',
	event = 'BufReadPost',
	config = function()
		local lint = require('lint')
		lint.linters_by_ft = {
			markdown = { 'markdownlint' },
			-- lua = { 'luacheck' },
		}

		vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
			callback = function()
				vim.async.run(function()
					lint.try_lint()
				end)
			end,
		})
	end,
}
