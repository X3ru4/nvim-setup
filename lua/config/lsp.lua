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

-- RIP fidget.nvim
local echo_id, win
local ui2 = require('vim._core.ui2')
vim.api.nvim_create_autocmd('LspProgress', {
	callback = function(ev)
		local value = ev.data.params.value

		if not value then
			return
		end

		local client = lsp.get_client_by_id(ev.data.client_id).name
		local kind = value.kind
		local message = value.message
		local percent = value.percentage
		local status = 'running'
		local title = value.title

		if kind == 'begin' then
			message = 'Loading…'
		end

		if kind == 'end' then
			message = 'Done ✓'
			percent = 100
			status = 'success'
		end

		local chunks = {
			{ ' ' },
			{ client .. ': ', 'Function' }, -- { '<msg>', '<highlight>' }
			{ title .. ' ' },
			{ percent .. '% ', 'Statement' },
			{ message, kind == 'end' and 'Added' or 'Changed' },
			{ ' ' },
		}

		local default_target = ui2.cfg.msg.targets.progress
		ui2.cfg.msg.targets.progress = 'msg'
		echo_id = vim.api.nvim_echo(chunks, false, {
			id = echo_id,
			kind = 'progress',
			source = 'lsp-progress',
			status = status,
		})
		ui2.cfg.msg.targets.progress = default_target
		if win ~= ui2.wins.msg then
			vim.api.nvim_win_set_config(ui2.wins.msg, { border = 'none' })
			vim.api.nvim_set_option_value('winhighlight', 'NormalFloat:StatusLine', { win = ui2.wins.msg })
		end
		win = ui2.wins.msg
	end,
})
