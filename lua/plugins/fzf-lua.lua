return {
	"ibhagwan/fzf-lua",
	opts = {
		winopts = {
			preview = {
				hidden = "hidden",
			},
		},
	},
	keys = function()
		local fzf = require("fzf-lua")
		return {

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
					fzf.highlights()
				end,
				desc = "Find highlights",
			},

			{
				"<leader>fd",
				function()
					fzf.diagnostics_document()
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
		}
	end,
}
