return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				-- Use the following command to install the copilot-lsp npm install -g @github/copilot-language-server
				vim.g.copilot_nes_debounce = 500
			end,
			opts = {
				nes = {
					move_count_threshold = 3, -- Clear after 3 cursor movements
				},
			},
		},
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			nes = {
				enabled = true,
				keymap = {
					accept_and_goto = "<Tab>",
					accept = false,
					dismiss = "<Esc>",
				},
			},
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
}
