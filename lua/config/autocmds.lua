local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })

autocmd('TextYankPost', {
	group = group,
	callback = function()
		vim.hl.hl_op({ higroup = 'Yank' })
	end,
	desc = 'Highlight on yank',
})
autocmd('TextPutPost', {
	group = group,
	callback = function()
		vim.hl.hl_op({ higroup = 'Paste' })
	end,
	desc = 'Highlight on paste',
})

autocmd({ 'InsertEnter', 'InsertLeave' }, {
	group = group,
	callback = function(ev)
		vim.wo.cursorline = ev.event == 'InsertLeave'
	end,
})

autocmd('ColorScheme', {
	group = group,
	callback = function()
		vim.cmd.LoadHlConfig({ bang = true })
	end,
	desc = 'Load highlight configuration when changing colorscheme',
})
autocmd('UIEnter', {
	group = group,
	once = true,
	callback = function()
		vim.cmd.LoadHlConfig()
	end,
	desc = 'Setup highlights',
})
