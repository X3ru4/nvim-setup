-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "vague" },
	},
	checker = { enabled = true },
	defaults = {
		lazy = false,
		version = false,
	},
	change_detection = {
		enabled = false,
	},
	ui = {
		border = "rounded",
		icons = {
			cmd = "󰌢",
			config = "󰒓",
			debug = "󰃤",
			event = "󱐋",
			favorite = "󰓎",
			ft = "󰩌",
			init = "󰒓",
			import = "󰋺",
			keys = "󰌓",
			lazy = "💤",
			loaded = "󰄴",
			not_loaded = "󰝦",
			plugin = "",
			runtime = "",
			require = "󰢱",
			source = "󰟒",
			start = "󰐊",
			task = "󰄬",
			list = {
				"󰘽",
				"➜",
				"*",
				"‒",
			},
		},
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"matchparen",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				-- "syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				-- "ftplugin",
			},
		},
	},
})

require("config.usercmds")
require("config.autocmds")
require("config.lsp")
require("config.keymaps")
