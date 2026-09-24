vim.loader.enable()

-- disable rtp plugins
local runtime_plugins = {
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

for _, var in ipairs(runtime_plugins) do
	vim.g['loaded_' .. var] = 1
end

vim.g.termfeatures = {
	osc52 = false,
}

require('config.options')
require('config.extra_options')
require('config.zpack')
require('config.usercmds')
require('config.autocmds')
require('config.keymaps')
