return {

	{
		"stevearc/oil.nvim",
		dependencies = {
			{
				enabled = false,
				"benomahony/oil-git.nvim",
				config = function()
					require("oil-git").setup({})
				end,
			},
			{
				enabled = false,
				"JezerM/oil-lsp-diagnostics.nvim",
				opts = {
					diagnostic_symbols = {
						error = require("config.icons").diagnostic.errr,
						warn = require("config.icons").diagnostic.warn,
						info = require("config.icons").diagnostic.info,
						hint = require("config.icons").diagnostic.hint,
					},
				},
			},
		},
		config = function()
			function _G.get_oil_winbar()
				local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
				local dir = require("oil").get_current_dir(bufnr)
				if dir then
					return vim.fn.fnamemodify(dir, ":~")
				else
					return vim.api.nvim_buf_get_name(0)
				end
			end

			local current_dir = require("oil").get_current_dir
			local fzf = require("fzf-lua")

			require("oil").setup({
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
				},
				preview_win = {
					win_options = {
						border = "soil",
					},
				},
				confirmation = {
					border = "rounded",
					win_options = {
						winblend = 20,
					},
				},
				keymaps = {
					["<C-s>"] = {},
					["<C-h>"] = nil,
					["g."] = nil,
					["-"] = nil,
					["<leader>ff"] = {
						function()
							fzf.files({
								cwd = current_dir(0),
							})
						end,
						mode = "n",
					},
					["<leader>fg"] = {
						function()
							fzf.live_grep({
								cwd = current_dir(0),
								winopts = {
									preview = {
										hidden = false,
									},
								},
							})
						end,
						mode = "n",
					},
					["<bs>"] = { "actions.parent", mode = "n" },
					[".."] = { "actions.toggle_hidden", mode = "n" },
					["q"] = { "actions.close", mode = "n" },
				},
				columns = {
					-- "permissions",
					"size",
					"icon",
					-- "mtime",
				},
			})
		end,
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>", desc = "Open oil" },
			{ "<leader>E", "<cmd>Oil .<cr>", desc = "Open oil home" },
		},
	},
}
