return {
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
						-- bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextHint" }).bg,
						bold = true,
					},
					{
						fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).fg,
						-- bg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).bg,
						bold = true,
					},
				},
				use_treesitter = true,
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				error_sign = true,
				-- animation related
				duration = 200,
				delay = 100,
			},
			indent = {
				enable = false,
				priority = 10,
				use_treesitter = true,
				chars = {
					"│",
					"¦",
					"┆",
					"┊",
				},
				delay = 100,
			},
		})
	end,
}
