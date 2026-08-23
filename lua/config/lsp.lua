local M = {}
local lsp = vim.lsp
local diagnostic = vim.diagnostic
local map = vim.keymap

function M.setup()
	diagnostic.config({
		virtual_text = {
			prefix = '',
			suffix = '',
		},
		underline = true,
		float = { source = 'if_many' },
		update_in_insert = false,
		signs = {
			text = {
				[diagnostic.severity.ERROR] = '',
				[diagnostic.severity.WARN] = '',
				[diagnostic.severity.INFO] = '',
				[diagnostic.severity.HINT] = '󰛨',
			},
		},
	})

	-- Disable inlay hint
	lsp.inlay_hint.enable(false)
	lsp.enable({
		'lua_ls',
		'rust_analyzer',
		'zls',
		-- 'jsonls',
	})

	map.set({ 'n', 'x' }, '-e', function()
		diagnostic.jump({ severity = diagnostic.severity.ERROR, count = -1 })
	end, { desc = 'Goto previous ERROR' })
	map.set({ 'n', 'x' }, '-w', function()
		diagnostic.jump({ severity = diagnostic.severity.WARN, count = -1 })
	end, { desc = 'Goto previous WARN' })
	map.set({ 'n', 'x' }, '-h', function()
		diagnostic.jump({ severity = diagnostic.severity.HINT, count = -1 })
	end, { desc = 'Goto previous HINT' })
	map.set({ 'n', 'x' }, '+e', function()
		diagnostic.jump({ severity = diagnostic.severity.ERROR, count = 1 })
	end, { desc = 'Goto next ERROR' })
	map.set({ 'n', 'x' }, '+w', function()
		diagnostic.jump({ severity = diagnostic.severity.WARN, count = 1 })
	end, { desc = 'Goto next WARN' })
	map.set({ 'n', 'x' }, '+h', function()
		diagnostic.jump({ severity = diagnostic.severity.HINT, count = 1 })
	end, { desc = 'Goto next HINT' })
	map.set({ 'n', 'i' }, '<C-k>', function()
		lsp.buf.signature_help({
			border = 'rounded',
			focus = false,
			close_events = { 'BufWinLeave', 'CursorMoved', 'CursorMovedI', 'ModeChanged' },
		})
	end, { desc = 'Signature help' })
	map.set({ 'n', 'i' }, '<C-l>', function()
		diagnostic.open_float(nil, {
			border = 'rounded',
			focus = false,
			close_events = { 'BufWinLeave', 'CursorMoved', 'CursorMovedI', 'ModeChanged' },
		})
	end, { desc = 'Open diagnostic float' })

	map.del({ 'n', 'x' }, 'gra') -- "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
	map.del('n', 'grx') -- "grx" is mapped to vim.lsp.codelens.run()
end

-- This function will be run when LSP attach to buffer.
function M.attach(ev)
	-- Remove the default LSP signature keymap.
	map.del('n', 'K', { buf = ev.buf })

	map.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action', buf = ev.buf })
	map.set('n', '<leader>ch', function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = 'Toggle inlay hint', buf = ev.buf })
end

return M
