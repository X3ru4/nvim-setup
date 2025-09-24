return {
	enabled = false,
	"royanirudd/clipboard-history.nvim",
	opts = {
		max_history = 20, -- Optional: set max history (default 100)
		enable_wsl_features = false, -- Set to true if you're using WSL and want Windows clipboard integration
	},
	keys = {
		{ "<leader>p", "<CMD>ClipboardHistory<CR>" },
	},
}
