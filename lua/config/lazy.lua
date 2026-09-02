-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local colorscheme = require('utils.colorscheme')

-- Setup lazy.nvim
require('lazy').setup({
	default = { lazy = true },
	spec = {
		{ import = 'plugins' },
		colorscheme.create_spec(),
	},
	install = {
		colorscheme = {
			colorscheme.variant or colorscheme.default,
		},
	},
	pkg = {
		source = { 'lazy', 'packspec' },
	},
	dev = { path = '~/projects/nvim' },
	rocks = { enabled = false },
	change_detection = { enabled = false },
	ui = {
		border = vim.o.winborder,
		backdrop = 100,
		icons = {
			cmd = '',
			config = '',
			debug = '',
			event = '',
			favorite = '',
			ft = '',
			init = '',
			import = '',
			keys = '',
			lazy = '💫 ',
			loaded = ' ',
			not_loaded = ' ',
			plugin = '',
			runtime = '',
			require = '󰢱',
			source = '',
			start = '',
			task = '',

			list = {
				'',
				'→',
				'+',
				'–',
			},
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
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
			},
		},
	},
})
