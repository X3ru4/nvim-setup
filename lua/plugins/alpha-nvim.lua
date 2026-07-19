return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "folke/persistence.nvim" },
	config = function()
		local config = require("alpha.themes.dashboard")
    -- Modify the button width.
		local button = function(sc, txt, keybind, keybind_opts)
			local btn = config.button(sc, txt, keybind, keybind_opts)
			local width = vim.api.nvim_win_get_width(0)
			btn.opts.width = math.min(width - 6, 40)
			return btn
		end

		local logo = {
			{
				"     ▄   ▄",
				" ▄█▄ █▀█▀█ ▄█▄",
				"▀▀████▄█▄████▀▀",
				"     ▀█▀█▀",
			},
			{
				"     ▀▄▀     ▄     ▄",
				"  ▄███████▄  ▀██▄██▀",
				"▄█████▀█████▄  ▄█",
				"███████▀████████▀",
				" ▄▄▄▄▄▄███████▀",
			},
			{
				"  ▄▄▄▄▄▄               ",
				" █▀██▀▀██              ",
				"   ██   ██             ",
				"   ██   ██ ▄█▀█▄▀█▄ ██▀",
				" ▄ ██   ██ ██▄█▀ ██▄██ ",
				" ▀██▀███▀ ▄▀█▄▄▄  ▀█▀  ",
			},
			{
				"       ▀▀ ▄       ",
				"▀█▄ ██▀██ ███▄███▄",
				" ██▄██ ██ ██ ██ ██",
				"  ▀█▀ ▄██▄██ ██ ▀█",
			},
			{
				" ▄                       ▀▀ ▄       ",
				" ████▄ ▄█▀█▄ ▄███▄▀█▄ ██▀██ ███▄███▄",
				" ██ ██ ██▄█▀ ██ ██ ██▄██ ██ ██ ██ ██",
				"▄██ ▀█▄▀█▄▄▄▄▀███▀  ▀█▀ ▄██▄██ ██ ▀█",
			},
		}

		math.randomseed(os.time())
		config.section.header.val = logo[math.random(#logo)]
		config.section.buttons.val = {
			button("e", "󰝒  New file", "<cmd>ene <CR>"),
			button("f", "󰱼  Search files", [[<cmd>lua require('fzf-lua').files()<cr>]]),
			button("o", "󱋡  Frecency/MRU", [[<cmd>lua require('fzf-lua').oldfiles()<cr>]]),
			button("x", "󰥨  Explore", "<cmd>Oil <CR>"),
			button("g", "󰺯  Grep", [[<cmd>lua require('fzf-lua').live_grep()<cr>]]),
			button("c", "󰒓  Configs", [[<cmd>lua require('fzf-lua').files({ cwd = "~/.config/nvim", })<cr>]]),
			button("r", "󰮳  Open last session", "<cmd>lua require('persistence').load()<cr>"),
			button("q", "󰈆  Quit", "<cmd>qa!<cr>"),
		}
		config.section.footer.val = {
			"CWD: " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/",
		}
		config.section.footer.opts.positon = "center"

		require("alpha").setup(config.config)
	end,
}
