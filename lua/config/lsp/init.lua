local M = {}
local icons = require('config.icons')

vim.diagnostic.config({
	virtual_text = {
		prefix = '',
		suffix = '',
	},
	underline = true,
	float = { source = 'if_many' },
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostic.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostic.Warn,
			[vim.diagnostic.severity.INFO] = icons.diagnostic.Info,
			[vim.diagnostic.severity.HINT] = icons.diagnostic.Hint,
		},
	},
})

-- Disable inlay hint
vim.lsp.inlay_hint.enable(false)

for name, config in require('utility.loader').load_file('lua/config/lsp') do
	if type(config) == 'table' and config.enabled ~= false then
		local server = name:gsub('%.lua$', '')
		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end
end

vimu.keymap.set_list({
	{
		{ 'n', 'x' },
		'[e',
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = -1 })
		end,
		{ desc = 'Goto previous ERROR' },
	},
	{
		{ 'n', 'x' },
		'[w',
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.WARN, count = -1 })
		end,
		{ desc = 'Goto previous WARN' },
	},
	{
		{ 'n', 'x' },
		'[h',
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.HINT, count = -1 })
		end,
		{ desc = 'Goto previous HINT' },
	},
	{
		{ 'n', 'x' },
		']e',
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = 1 })
		end,
		{ desc = 'Goto next ERROR' },
	},
	{
		{ 'n', 'x' },
		']w',
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.WARN, count = 1 })
		end,
		{ desc = 'Goto next WARN' },
	},
	{
		{ 'n', 'x' },
		']h',
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.HINT, count = 1 })
		end,
		{ desc = 'Goto next HINT' },
	},
	{
		{ 'n', 'i' },
		'<C-k>',
		function()
			vim.lsp.buf.signature_help({
				border = 'rounded',
				focus = false,
				close_events = { 'BufWinLeave', 'CursorMoved', 'CursorMovedI', 'ModeChanged' },
			})
		end,
		{ desc = 'Signature help' },
	},
	{
		{ 'n', 'i' },
		'<C-l>',
		function()
			vim.diagnostic.open_float(nil, {
				border = 'rounded',
				focus = false,
				close_events = { 'BufWinLeave', 'CursorMoved', 'CursorMovedI', 'ModeChanged' },
			})
		end,
		{ desc = 'Open diagnostic float' },
	},
})

vimu.keymap.del_list({
	{ { 'n', 'x' }, 'gra' }, -- "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
	{ 'n', 'grx' }, -- "grx" is mapped to vim.lsp.codelens.run()
})

-- This function will be run when LSP attach to buffer.
function M.attach(ev)
	-- Remove the default LSP signature keymap.
	vimu.keymap.del('n', 'K', { buf = ev.buf })

	vimu.keymap.set_list({
		{ { 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action', buf = ev.buf } },
		{
			'n',
			'<leader>ch',
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
			{ desc = 'Toggle inlay hint', buf = ev.buf },
		},
	})
end

return M
