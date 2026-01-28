return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
		dependencies = {
			"folke/persistence.nvim",
		},
		config = function()
			local config = require("alpha.themes.dashboard")
			local button = function(sc, txt, keybind, keybind_opts)
				local btn = config.button(sc, txt, keybind, keybind_opts)
				local tbl = vim.api.nvim_exec2("echo &columns", { output = true })
				local width = tonumber(tbl.output) or 0
				btn.opts.width = math.min(width - 4, 40)
				return btn
			end

			config.section.header.val = "Hello!"
			config.section.buttons.val = {
				button("n", "  New file", "<cmd>ene <CR>"),
				button("f", "  Find files", [[<cmd>lua require('fzf-lua').files()<cr>]]),
				button("e", "  Explore", "<cmd>Oil <CR>"),
				button("o", "  Frecency/MRU", [[<cmd>lua require('fzf-lua').oldfiles()<cr>]]),
				button("g", "  Grep", [[<cmd>lua require('fzf-lua').live_grep()<cr>]]),
				button("c", "  Configs", [[<cmd>lua require('fzf-lua').files({ cwd = "~/.config/nvim", })<cr>]]),
				button("r", "  Open last session", "<cmd>lua require('persistence').load()<cr>"),
				button("q", "󰩈  Quit", "<cmd>qa!<cr>"),
			}
			config.section.footer.val = "@X3ru4"

			require("alpha").setup(config.config)
		end,
	},
}
