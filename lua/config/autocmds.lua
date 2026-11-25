local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })

autocmd('TextYankPost', {
	group = augroup,
	callback = function()
		vim.hl.hl_op({ higroup = 'Yank' })
	end,
	desc = 'Highlight on yank',
})
autocmd('TextPutPost', {
	group = augroup,
	callback = function()
		vim.hl.hl_op({ higroup = 'Paste' })
	end,
	desc = 'Highlight on paste',
})

autocmd({ 'InsertEnter', 'InsertLeave' }, {
	group = augroup,
	callback = function(ev)
		vim.wo.cursorline = ev.event == 'InsertLeave'
	end,
})

autocmd('ColorScheme', {
	group = augroup,
	callback = function()
		vim.cmd.LoadHlConfig({ bang = true })
	end,
	desc = 'Load highlight configuration when changing colorscheme',
})
autocmd('UIEnter', {
	group = augroup,
	once = true,
	callback = function()
		vim.cmd.LoadHlConfig()
	end,
	desc = 'Setup highlights',
})

vim.opt.cmdheight = 0
autocmd('CmdlineEnter', {
	group = augroup,
	command = 'set cmdheight=1',
})
autocmd('CmdlineLeave', {
	group = augroup,
	command = 'set cmdheight=0',
})
