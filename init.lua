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

vim.g.termfeatures = {
	osc52 = false,
}

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('vim._core.ui2').enable({ enable = true })
require('config.options')
require('config.messages')
vim.opt.statusline = [[%{%v:lua.require('config.statusline')()%}]]
require('config.zpack')
require('config.commands')
require('config.keymaps')
require('config.lsp')
