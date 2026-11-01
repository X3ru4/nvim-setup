-- install with vim.pack directly
vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })

-- automatically import specs from `./lua/plugins/`
require('zpack').setup({
	defaults = {
		confirm = true,
		lazy = true,
	},
	dev = {
		path = '~/projects/nvim',
	},
})
