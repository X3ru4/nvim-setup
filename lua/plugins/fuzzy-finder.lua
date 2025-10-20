return {

	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		opts = {
			winopts = {
				preview = {
					hidden = "hidden",
				},
				row = 0.4,
				backdrop = 60,
        treesitter = {
          enabled = false
        },
        fullscreen = true
			},
		},
		keys = function()
			local fzf = require("fzf-lua")
			return {

				{
					"<leader>fr",
					function()
						fzf.registers()
					end,
					desc = "Find register",
				},

				{
					"<leader>ff",
					function()
						fzf.files()
					end,
					desc = "Find file CWD",
				},

				{
					"<leader>fF",
					function()
						fzf.files({ cwd = vim.fn.expand("%:h:p") })
					end,
					desc = "Find file",
				},

				{
					"<leader>fc",
					function()
						fzf.files({ cwd = "~/.config/nvim" })
					end,
					desc = "Find config files",
				},

				{
					"<leader>fb",
					function()
						fzf.buffers({ filename_only = true })
					end,
					desc = "Find buffers",
				},

				{
					"<leader>fh",
					function()
						fzf.highlights({
							winopts = {
								preview = {
									hidden = false,
								},
							},
						})
					end,
					desc = "Find highlights",
				},

				{
					"<leader>fd",
					function()
						fzf.diagnostics_document({
							winopts = {
								preview = {
									hidden = false,
								},
							},
						})
					end,
					desc = "Find diagnostics",
				},

				{
					"<leader>fo",
					function()
						fzf.oldfiles()
					end,
					desc = "Find old files",
				},

				{
					"<leader>fC",
					function()
						fzf.colorschemes()
					end,
					desc = "Find colorschemes",
				},

				{
					"<leader>ft",
					function()
						fzf.filetypes()
					end,
					desc = "Find filetypes",
				},

				{
					"<leader>fg",
					function()
						fzf.live_grep({
							winopts = {
								preview = {
									hidden = false,
								},
							},
						})
					end,
					desc = "Live grep",
				},
			}
		end,
	},
}
