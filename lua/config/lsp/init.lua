local M = {}
local icons = require("config.icons").diagnostic
local severity_icons = {
	[vim.diagnostic.severity.ERROR] = icons.Error,
	[vim.diagnostic.severity.WARN] = icons.Warn,
	[vim.diagnostic.severity.INFO] = icons.Info,
	[vim.diagnostic.severity.HINT] = icons.Hint,
}

vim.lsp.inlay_hint.enable(false)
vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			return " " .. severity_icons[diagnostic.severity]
		end,
		suffix = " ",
	},
	underline = false,
	float = { source = "if_many" },
	update_in_insert = false,
	signs = {
		text = severity_icons,
	},
})

for name, config in require("utility.loader").load_file("lua/config/lsp") do
	if type(config) == "table" then
		vim.lsp.config(name:gsub("%.lua$", ""), config)
	end
end

local keymap = require("utility.keymap")

keymap.set_list({
	{
		{ "n", "x" },
		"[e",
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = -1 })
		end,
		{ desc = "Goto previous ERROR" },
	},
	{
		{ "n", "x" },
		"[w",
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.WARN, count = -1 })
		end,
		{ desc = "Goto previous WARN" },
	},
	{
		{ "n", "x" },
		"[h",
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.HINT, count = -1 })
		end,
		{ desc = "Goto previous HINT" },
	},
	{
		{ "n", "x" },
		"]e",
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = -1 })
		end,
		{ desc = "Goto next ERROR" },
	},
	{
		{ "n", "x" },
		"]w",
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.WARN, count = -1 })
		end,
		{ desc = "Goto next WARN" },
	},
	{
		{ "n", "x" },
		"]h",
		function()
			vim.diagnostic.jump({ severity = vim.diagnostic.severity.HINT, count = -1 })
		end,
		{ desc = "Goto next HINT" },
	},

	{ "n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" } },
	{
		"n",
		"<leader>ch",
		function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end,
		{ desc = "Toggle inlay hint" },
	},
	{
		{ "n", "i" },
		"<C-k>",
		function()
			vim.lsp.buf.signature_help({
				border = "rounded",
				focus = false,
				close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
			})
		end,
		{ desc = "Signature help" },
	},
	{
		{ "n", "i" },
		"<C-l>",
		function()
			vim.diagnostic.open_float(nil, {
				border = "rounded",
				focus = false,
				close_events = { "BufWinLeave", "CursorMoved", "CursorMovedI", "ModeChanged" },
			})
		end,
		{ desc = "Open diagnostic float" },
	},
})

-- This function will be run when LSP attach to buffer.
function M.attach(ev)
	-- Remove the default LSP signature keymap.
	keymap.del("n", "K", { buf = ev.buf })
end

return M
