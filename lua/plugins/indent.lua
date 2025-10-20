return {

	{
		enabled = false,
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					priority = 15,
					style = {
						{
							fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextHint" }).fg,
							bold = true,
						},
						{
							fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).fg,
							bold = true,
						},
					},
					use_treesitter = true,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = "",
					},
					error_sign = true,
					-- animation related
					duration = 300,
					delay = 100,
				},
			})
		end,
	},
}
