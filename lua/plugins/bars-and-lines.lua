return {

	{
		"Bekaboo/dropbar.nvim",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				once = true,
				group = vim.api.nvim_create_augroup("dropbar.load", {}),
				callback = function()
					if vim.g.loaded_dropbar then
						return
					end
					require("dropbar").setup({
						icons = {
							ui = {
								bar = {
									separator = "  ",
									extends = "…",
								},
							},
						},
						sources = {
							path = {
								max_depth = 1,
							},
						},
						menu = {
							win_configs = {
								border = "rounded",
							},
						},
					})
				end,
			})
		end,
		keys = function()
			local api = require("dropbar.api")
			return {
				{ "<Leader>;", api.pick, desc = "Pick symbols in winbar" },
				{ "[;", api.goto_context_start, desc = "Go to start of current context" },
				{ "];", api.select_next_context, desc = "Select next context" },
			}
		end,
	},
}
