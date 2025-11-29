return {

	{
		"luukvbaal/statuscol.nvim",
    enabled = false,
		event = "VeryLazy",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- configuration goes here, for example:
				relculright = true,
				segments = {
					{
						text = { builtin.foldfunc },
						click = "v:lua.ScFa",
					},
					{
						sign = {
							namespace = { "diagnostic/signs" }, -- Target the diagnostic signs namespace
							maxwidth = 2, -- Adjust width as needed
							auto = true, -- Automatically show signs
							colwidth = 1, -- Set column width for signs
							wrap = true, -- Wrap signs if necessary
						},
						click = "v:lua.ScSa", -- Optional: define a click handler for signs
					},
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{
						sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
						click = "v:lua.ScSa",
					},
				},
			})
		end,
	},

	{
		"Bekaboo/dropbar.nvim",
		enabled = true,
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
