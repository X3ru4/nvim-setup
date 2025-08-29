local icons = require("config.icons").icons

return {
	{
		"romgrk/barbar.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			icons = {
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},
				preset = "default",
				pinned = { button = icons.pinned, filename = false },
				modified = { button = icons.modified },
			},
			maximum_length = 20,
		},
		version = "^1.0.0",
		keys = {
			{ "<S-h>", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
			{ "<S-l>", "<cmd>BufferNext<cr>", desc = "Next buffer" },
			{ "<A-1>", "<Cmd>BufferGoto 1<CR>" },
			{ "<A-2>", "<Cmd>BufferGoto 2<CR>" },
			{ "<A-3>", "<Cmd>BufferGoto 3<CR>" },
			{ "<A-4>", "<Cmd>BufferGoto 4<CR>" },
			{ "<A-5>", "<Cmd>BufferGoto 5<CR>" },
			{ "<A-6>", "<Cmd>BufferGoto 6<CR>" },
			{ "<A-7>", "<Cmd>BufferGoto 7<CR>" },
			{ "<A-8>", "<Cmd>BufferGoto 8<CR>" },
			{ "<A-9>", "<Cmd>BufferGoto 9<CR>" },
			{ "<A-0>", "<Cmd>BufferLast<CR>" },
			-- Close buffer
			{ "<leader>bd", "<Cmd>BufferClose<CR>" },

			-- Magic buffer-picking mode
			{ "<C-p>", "<Cmd>BufferPick<CR>" },

			-- Sort automatically by...
			{ "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>" },
			{ "<Space>bn", "<Cmd>BufferOrderByName<CR>" },
			{ "<Space>bD", "<Cmd>BufferOrderByDirectory<CR>" },
			{ "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>" },
			{ "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>" },
		},
	},
}
