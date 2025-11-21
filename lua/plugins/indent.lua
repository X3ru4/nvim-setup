return {

  {
    "nvimdev/indentmini.nvim",
    enabled = false,
		event = { "BufReadPre", "BufNewFile" },
    opts = {}
  },

	{
		"shellRaining/hlchunk.nvim",
    enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					priority = 15,
					style = {
						{
							fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextHint" }).fg,
							bold = false,
						},
						{
							fg = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" }).fg,
							bold = false,
						},
					},
					use_treesitter = false,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
					error_sign = true,
					-- animation related
					duration = 0,
					delay = 20,
				},
				indent = {
          enable = true,
					use_treesitter = false,
					style = {
            {
              bold = false
            }
          },
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
}
