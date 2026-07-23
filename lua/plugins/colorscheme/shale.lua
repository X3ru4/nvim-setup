return {
	"smit4k/shale.nvim",
	name = "shale",
	config = function()
		require("shale").setup({
			italic_comments = true,
			italic_keywords = true,
			transparent = false,
		})

		vim.cmd.colorscheme("shale")
		local hl = vimu.highlight
		hl.insert({
			extra = {
				hl.modify("FloatBorder", { bg = hl.getbg("NormalFloat") }),
			},
		})
	end,
}
