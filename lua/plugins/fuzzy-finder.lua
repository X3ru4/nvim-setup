return {

	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		config = function()
			require("fzf-lua").setup({
				file_icon_padding = " ",
				winopts = {
					preview = {
						hidden = "hidden",
					},
					row = 0.4,
					backdrop = 60,
					treesitter = {
						enabled = false,
					},
					fullscreen = true,
				},
				fzf_colors = {
					true, -- inherit fzf colors that aren't specified below from
					-- the auto-generated theme similar to `fzf_colors=true`
					["fg"] = { "fg", "CursorLine" },
					["bg"] = { "bg", "Normal" },
					["hl"] = { "fg", "Comment" },
					["fg+"] = { "fg", "Normal" },
					["bg+"] = { "bg", { "CursorLine", "Normal" } },
					["hl+"] = { "fg", "Statement" },
					["info"] = { "fg", "PreProc" },
					["prompt"] = { "fg", "Conditional" },
					["pointer"] = { "fg", "Exception" },
					["marker"] = { "fg", "Keyword" },
					["spinner"] = { "fg", "Label" },
					["header"] = { "fg", "Comment" },
					-- ["gutter"] = "-1",
				},
			})
		end,
		keys = function()
			local fzf = require("fzf-lua")
			return {

				{
					"<leader>fs",
					function()
						fzf.spell_suggest({
							prompt = "› ",
						})
					end,
					desc = "spell_suggest",
				},

				{
					"<leader>fr",
					function()
						fzf.registers({
							prompt = " ",
						})
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
						fzf.files()
					end,
					desc = "Find file",
				},

				{
					"<leader>fc",
					function()
						fzf.files({
							cwd = "~/.config/nvim",
						})
					end,
					desc = "Find config files",
				},

				{
					"<leader>fb",
					function()
						fzf.buffers({
							prompt = "› ",
							filename_only = true,
						})
					end,
					desc = "Find buffers",
				},

				{
					"<leader>fh",
					function()
						fzf.highlights({
							prompt = "› ",
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
							prompt = "› ",
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
						fzf.oldfiles({
							prompt = "› ",
						})
					end,
					desc = "Find old files",
				},

				{
					"<leader>fC",
					function()
						fzf.colorschemes({
							prompt = " ",
						})
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
