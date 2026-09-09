-- install with vim.pack directly
vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })

-- Make sure to setup `mapleader` and `maplocalleader` before loading
-- zpack.nvim so that keymaps referenced from zpack.Spec are aware
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- automatically import specs from `./lua/plugins/`
require('zpack').setup({
	defaults = {
		confirm = false,
		lazy = true,
	},
	dev = {
		path = '~/projects/nvim'
	}
})
