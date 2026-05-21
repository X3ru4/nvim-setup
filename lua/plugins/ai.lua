return {
	{
		"zbirenbaum/copilot.lua",
    enabled = vim.g.plugin.ai,
    commit = "94b22035e31e82821d015f6481ea3c17800e55b7",
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
				enabled = false,
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
