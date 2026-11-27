vim.loader.enable()

-- disable runtimepath plugins
local rtp_plugins = {
	'fzf',
	'gzip',
	'man',
	'matchit',
	'matchparen',
	'netrw',
	'nvim_net_plugin',
	'remote_plugins',
	'rpluginzipPlugin',
	'tarPlugin',
	'tutor_mode_plugin',
	'zipPlugin',
}

for _, name in ipairs(rtp_plugins) do
	vim.g['loaded_' .. name] = 1
end

vim.g.termfeatures = { osc52 = false }
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.opt.statusline = [[%{%v:lua.require('config.statusline')()%}]]

require('vim._core.ui2').enable({ enable = true })
require('config.options')
require('config.input')
require('config.messages')
require('config.zpack')
require('config.keymaps')
require('config.autocmds')
require('config.usercmds')
require('config.lsp')

local augroup = vim.api.nvim_create_augroup('MyModule', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPre', 'TabNew' }, {
	group = augroup,
	once = true,
	callback = function()
		vim.opt.tabline = [[%{%v:lua.require('config.tabline')()%}]]
		vim.opt.showtabline = 2
	end,
})
