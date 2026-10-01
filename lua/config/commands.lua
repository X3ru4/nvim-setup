local usercmd = vim.api.nvim_create_user_command
local conf_path = vim.fn.stdpath('config')

usercmd('LoadHlConfig', function(opts)
	if opts.bang then
		require('utils.highlight').use_cache = false
	end
	vim.cmd.luafile(conf_path .. '/lua/config/highlights.lua')
end, { bang = true })

local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })

-- Highlight on yank.
autocmd('TextYankPost', {
	group = group,
	callback = function()
		vim.hl.on_yank({ higroup = 'Yank', timeout = 150, priority = 10000 })
	end,
})
autocmd({ 'InsertLeave', 'WinEnter' }, {
	group = group,
	callback = function()
		vim.o.cursorline = true
	end,
})
autocmd({ 'InsertEnter', 'WinLeave' }, {
	group = group,
	callback = function()
		vim.o.cursorline = false
	end,
})

local highlight = require('utils.highlight')
-- Load highlight configuration when changing colorscheme.
autocmd('ColorScheme', {
	group = group,
	callback = function()
		highlight.use_cache = false -- Stop using cache.
		vim.cmd.LoadHlConfig()
	end,
})
-- Setup highlights
autocmd('UIEnter', {
	group = group,
	once = true,
	callback = function()
		vim.cmd.LoadHlConfig()
	end,
})
-- LSP
autocmd('User', {
	group = group,
	pattern = 'VeryLazy',
	once = true,
	callback = function()
		require('config.lsp').setup()
	end,
})
autocmd('LspAttach', {
	group = group,
	callback = function(ev)
		require('config.lsp').attach(ev)
	end,
})
