vim.loader.enable()

-- disable rtp plugins
local rtp_plugins = {
	-- 'editorconfig',
	'fzf',
	'gzip',
	'man',
	'matchit',
	'matchparen',
	'net',
	'netrwPlugin',
	'osc52',
	'rplugin',
	-- 'spellfile',
	'tarPlugin',
	'zipPlugin',
	'tutor',
	'rpluginzipPlugin',
}

for _, plugin in ipairs(rtp_plugins) do
  vim.g['loaded_' .. plugin] = 1
end

require('config.options')
require('config.extra_options')
require('config.zpack')
require('config.usercmds')
require('config.autocmds')
require('config.keymaps')
