local dia = vim.diagnostic
local lsp = vim.lsp
local km = vim.keymap

lsp.inlay_hint.enable(false)
lsp.enable({
	'lua_ls',
	'rust_analyzer',
	'zls',
	-- 'jsonls',
})

km.set({ 'n', 'x' }, '<leader>ca', lsp.buf.code_action, { desc = 'Code action' })
km.set('n', '<leader>ch', function()
	lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hint' })

local close_events = { 'BufWinLeave', 'CursorMoved', 'CursorMovedI', 'ModeChanged' }
km.set({ 'n', 'i' }, '<C-k>', function()
	lsp.buf.signature_help({
		close_events = close_events,
		title = '  Signature help ',
		title_pos = 'center',
	})
end, { desc = 'Signature help' })
km.set('n', 'K', function()
	lsp.buf.hover({
		close_events = close_events,
		title = '  Info ',
		title_pos = 'center',
	})
end, { desc = 'Signature help' })
km.set('n', '<C-j>', function()
	dia.open_float(nil, {
		close_events = close_events,
		title = '  Diagnostics ',
		title_pos = 'center',
	})
end, { desc = 'Open diagnostic float' })

km.set('n', 'grn', lsp.buf.rename, { desc = 'LSP Rename' })
km.del({ 'n', 'x' }, 'gra') -- "gra" (Normal and Visual mode) is mapped to lsp.buf.code_action()
km.del('n', 'grx') -- "grx" is mapped to lsp.codelens.run()

km.set({ 'n', 'x' }, '[e', function()
	dia.jump({ severity = dia.severity.ERROR, count = -1 })
end, { desc = 'Goto previous ERROR' })
km.set({ 'n', 'x' }, ']e', function()
	dia.jump({ severity = dia.severity.ERROR, count = 1 })
end, { desc = 'Goto next ERROR' })
km.set({ 'n', 'x' }, '[w', function()
	dia.jump({ severity = dia.severity.WARN, count = -1 })
end, { desc = 'Goto previous WARN' })
km.set({ 'n', 'x' }, ']w', function()
	dia.jump({ severity = dia.severity.WARN, count = 1 })
end, { desc = 'Goto next WARN' })

local signs = {
	[dia.severity.ERROR] = '',
	[dia.severity.WARN] = '',
	[dia.severity.INFO] = '',
	[dia.severity.HINT] = '󱠂',
}
local signs_hl = {
	[dia.severity.ERROR] = 'DiagnosticSignError',
	[dia.severity.WARN] = 'DiagnosticSignWarn',
	[dia.severity.INFO] = 'DiagnosticSignInfo',
	[dia.severity.HINT] = 'DiagnosticSignHint',
}

dia.config({
	virtual_text = {
		prefix = '●',
		suffix = '',
	},
	underline = true,
	float = {
		source = 'if_many',
		header = '',
		prefix = function(opts)
			return ' ' .. signs[opts.severity] .. ' ', signs_hl[opts.severity]
		end,
	},
	update_in_insert = false,
	signs = {
		text = signs,
	},
})
