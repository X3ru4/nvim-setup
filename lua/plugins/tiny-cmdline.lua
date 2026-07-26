return {
	"rachartier/tiny-cmdline.nvim",
	event = "UIEnter",
	priority = 1000,
	config = function()
		vim.o.cmdheight = 0
		require("tiny-cmdline").setup({
			on_reposition = require("tiny-cmdline").adapters.blink,
			border = nil,
			native_types = { "/", "?" },
			title = {
				enabled = true,
				pos = "center",
			},
		})

		vimu.highlight.add_callback("tiny-cmdline", function()
			vimu.highlight.set("TinyCmdlineNormal", { link = "NormalFloat" })
		end)
	end,
}
