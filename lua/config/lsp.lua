local M = {}
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local map = vim.keymap
local has_nf = vime.has_nerdfont

local lsp_enable = {
	'lua_ls',
	'rust_analyzer',
	'zls',
	-- 'jsonls',
}

local signs = {
	[diagnostic.severity.ERROR] = has_nf and '' or 'E',
	[diagnostic.severity.WARN] = has_nf and '' or 'W',
	[diagnostic.severity.INFO] = has_nf and '' or 'I',
	[diagnostic.severity.HINT] = has_nf and '󱠂' or 'H',
}
local signs_hl = {
	[diagnostic.severity.ERROR] = 'DiagnosticSignError',
	[diagnostic.severity.WARN] = 'DiagnosticSignWarn',
	[diagnostic.severity.INFO] = 'DiagnosticSignInfo',
	[diagnostic.severity.HINT] = 'DiagnosticSignHint',
}
local title = {
	signature = has_nf and '  Signature help ' or ' Signature help ',
	hover = has_nf and '  Info ' or ' Info ',
	diagnostic = has_nf and '  Diagnostics ' or ' Diagnostics ',
}

function M.setup()
	diagnostic.config({
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

	map.set({ 'n', 'x' }, '[e', function()
		diagnostic.jump({ severity = diagnostic.severity.ERROR, count = -1 })
	end, { desc = 'Goto previous ERROR' })
	map.set({ 'n', 'x' }, '[w', function()
		diagnostic.jump({ severity = diagnostic.severity.WARN, count = -1 })
	end, { desc = 'Goto previous WARN' })
	map.set({ 'n', 'x' }, '[h', function()
		diagnostic.jump({ severity = diagnostic.severity.HINT, count = -1 })
	end, { desc = 'Goto previous HINT' })
	map.set({ 'n', 'x' }, ']e', function()
		diagnostic.jump({ severity = diagnostic.severity.ERROR, count = 1 })
	end, { desc = 'Goto next ERROR' })
	map.set({ 'n', 'x' }, ']w', function()
		diagnostic.jump({ severity = diagnostic.severity.WARN, count = 1 })
	end, { desc = 'Goto next WARN' })
	map.set({ 'n', 'x' }, ']h', function()
		diagnostic.jump({ severity = diagnostic.severity.HINT, count = 1 })
	end, { desc = 'Goto next HINT' })

	-- Disable inlay hint
	lsp.inlay_hint.enable(false)
	lsp.enable(lsp_enable)

	map.set('n', 'grn', vim.lsp.buf.rename, { desc = 'LSP Rename' })

	local close_events = { 'BufWinLeave', 'CursorMoved', 'CursorMovedI', 'ModeChanged' }
	map.set({ 'n', 'i' }, '<C-k>', function()
		lsp.buf.signature_help({
			close_events = close_events,
			title = title.signature,
			title_pos = 'center',
		})
	end, { desc = 'Signature help' })
	map.set('n', 'K', function()
		lsp.buf.hover({
			close_events = close_events,
			title = title.hover,
			title_pos = 'center',
		})
	end, { desc = 'Signature help' })
	map.set('n', '<C-j>', function()
		diagnostic.open_float(nil, {
			close_events = close_events,
			title = title.diagnostic,
			title_pos = 'center',
		})
	end, { desc = 'Open diagnostic float' })

	map.del({ 'n', 'x' }, 'gra') -- "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
	map.del('n', 'grx') -- "grx" is mapped to vim.lsp.codelens.run()
end

-- This function will be run when LSP attach to buffer.
function M.attach(ev)
	map.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action', buf = ev.buf })
	map.set('n', '<leader>ch', function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = 'Toggle inlay hint', buf = ev.buf })
end

return M
