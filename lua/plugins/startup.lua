return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
    dependencies = {
      "folke/persistence.nvim"
    },
		config = function()
			local config = require("alpha.themes.startify")
			config.section.header.val = "n30vim"
			config.section.footer.opts = {
				hl = "Type",
				shrink_margin = false,
			}
      config.section.footer.type = "text"
      config.section.footer.val = "\nX3ru4  "
			config.section.mru.val = {}
			config.section.mru_cwd.val = {}
			config.section.top_buttons.val = {
				config.button("e", "New file", "<cmd>ene <CR>"),
				config.button("f", "Find files", [[<cmd>lua require('fzf-lua').files()<cr>]]),
				config.button("o", "Old files", [[<cmd>lua require('fzf-lua').oldfiles({ prompt = "› ", })<cr>]]),
				config.button("c", "Config", [[<cmd>lua require('fzf-lua').files({ cwd = "~/.config/nvim", })<cr>]]),
				config.button("r", "Restore session", "<cmd>lua require('persistence').load()<cr>"),
			}
			require("alpha").setup(config.config)
		end,
	},
}
