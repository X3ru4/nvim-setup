local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opts = { clear = true }
local groups = {
	misc = augroup('MyAuGroupMisc', opts),
	control = augroup('MyAuGroupControl', opts),
}

---Miscelaneous
-- Highlight on yank.
autocmd('TextYankPost', {
	group = groups.misc,
	callback = function()
		vim.hl.on_yank({ higroup = 'Yank', timeout = 150, priority = 10000 })
	end,
})
autocmd({ 'InsertLeave', 'WinEnter' }, {
	group = groups.misc,
	callback = function()
		vim.o.cursorline = true
	end,
})
autocmd({ 'InsertEnter', 'WinLeave' }, {
	group = groups.misc,
	callback = function()
		vim.o.cursorline = false
	end,
})

local highlight = require('utils.highlight')
---Control
-- Load highlight configuration when changing colorscheme.
autocmd('ColorScheme', {
	group = groups.control,
	callback = function()
		highlight.use_cache = false -- Stop using cache.
		vim.cmd.LoadHlConfig()
		vim.cmd.redraw()
	end,
})
-- Setup highlights
autocmd('UIEnter', {
	group = groups.control,
	once = true,
	callback = function()
		vim.cmd.LoadHlConfig()
	end,
})
-- LSP
autocmd('User', {
	group = groups.control,
	pattern = 'VeryLazy',
	once = true,
	callback = function()
		require('config.lsp').setup()
	end,
})
autocmd('LspAttach', {
	group = groups.control,
	callback = function(ev)
		require('config.lsp').attach(ev)
	end,
})
