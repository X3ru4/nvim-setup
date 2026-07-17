return {
	url = "https://codeberg.org/andyg/leap.nvim",
	-- For more colors and futures, flash.nvim isn the best choice.
	enabled = true,
	event = "VeryLazy",
	keys = {
		{
			"s",
			"<Plug>(leap)",
			mode = { "n", "x", "o" },
			nowait = true,
			remap = true,
		},
		-- {
		-- 	"S",
		-- 	"<Plug>(leap-from-window)",
		-- 	mode = "n",
		-- 	nowait = true,
		-- },
		{
			"R",
			function()
				require("leap.treesitter").select({
					opts = require("leap.user").with_traversal_keys("R", "r"),
				})
			end,
			mode = { "x", "o" },
		},
	},
	config = function(_, opts)
		local leap = require("leap")
		for k, v in pairs(opts) do
			leap.opts[k] = v
		end

		leap.opts.preview = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
		end

		leap.opts.equivalence_classes = {
			" \t\r\n",
			"([{",
			")]}",
			"'\"`",
		}

		require("leap.user").set_repeat_keys("<enter>", "<backspace>")

		-- vim.keymap.del({ "x", "o" }, "x")
		-- vim.keymap.del({ "x", "o" }, "X")
	end,
}
