return {

	{
		"stevearc/oil.nvim",
		enabled = true,
		cmd = "Oil",
		-- Extensions
		dependencies = {
			{
				enabled = true,
				"malewicz1337/oil-git.nvim",
				config = function()
					require("oil-git").setup({
						symbols = {
							file = {
								added = " ",
								modified = " ",
								renamed = " ",
								deleted = " ",
								copied = " ",
								conflict = " ",
								untracked = " ",
								ignored = " ",
							},
							directory = {
								added = " ",
								modified = " ",
								renamed = " ",
								deleted = " ",
								copied = " ",
								conflict = " ",
								untracked = " ",
								ignored = " ",
							},
						},
						highlights = {
							OilGitAdded = { link = "DiagnosticOk" },
							OilGitModified = { link = "DiagnosticWarn" },
							OilGitRenamed = { link = "DiagnosticWarn" },
							OilGitDeleted = { link = "DiagnosticError" },
							OilGitCopied = { link = "DiagnosticHint" },
							OilGitConflict = { link = "DiagnosticInfo" },
							OilGitUntracked = { link = "DiagnosticInfo" },
							OilGitIgnored = { link = "DiagnosticInfo" },
						},
					})
				end,
			},
			{
				enabled = false,
				"JezerM/oil-lsp-diagnostics.nvim",
				opts = {
					diagnostic_symbols = {
						error = require("config.icons").diagnostic.Error,
						warn = require("config.icons").diagnostic.Warn,
						info = require("config.icons").diagnostic.Info,
						hint = require("config.icons").diagnostic.Hint,
					},
				},
			},
		},
		config = function()
			function _G.get_oil_winbar()
				local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
				local dir = require("oil").get_current_dir(bufnr)
				if dir then
					return "%#OilMove#" .. vim.fn.fnamemodify(dir, ":~")
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
					win_options = {},
				},
				confirmation = {
					border = "rounded",
					win_options = {},
				},
				progress = {
					border = "rounded",
					win_options = {},
				},
				delete_to_trash = false,
				use_default_keymaps = true,
				keymaps = {
					["<C-s>"] = false,
					["<C-h>"] = false,
					["g."] = false,
					["-"] = false,
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
							})
						end,
						mode = "n",
					},
					["<bs>"] = { "actions.parent", mode = "n" },
					["."] = { "actions.toggle_hidden", mode = "n" },
					["q"] = { "actions.close", mode = "n" },
					["gc"] = {
						function()
							vim.ui.input({ prompt = "Search  ", default = "./" }, function(input)
								if input then
									vim.cmd("Oil " .. input)
								end
							end)
						end,
						mode = "n",
					},
					["gf"] = {
						function()
							vim.ui.input({ prompt = "Search  ", default = "~/" }, function(input)
								if input then
									vim.cmd("Oil " .. input)
								end
							end)
						end,
						mode = "n",
					},
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
			{ "gf" },
		},
	},

	{
		-- oil.nvim is better than
		"mikavilpas/yazi.nvim",
		enabled = false,
		version = "*", -- use the latest stable version
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>E",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			floating_window_scaling_factor = 1,
			integrations = {
				--- What should be done when the user wants to grep in a directory
				grep_in_directory = function(directory)
					require("fzf-lua").live_grep({
						cwd = directory,
					})
				end,

				grep_in_selected_files = function(selected_files)
					require("fzf-lua").live_grep({
						cwd = selected_files,
					})
				end,
			},
			keymaps = {
				show_help = "<f1>",
				open_file_in_vertical_split = "<c-v>",
				open_file_in_horizontal_split = "<c-x>",
				open_file_in_tab = "<c-t>",
				grep_in_directory = "<c-s>",
				replace_in_directory = "<c-g>",
				cycle_open_buffers = "<tab>",
				copy_relative_path_to_selected_files = "<c-y>",
				send_to_quickfix_list = "<c-q>",
				change_working_directory = "<c-\\>",
				open_and_pick_window = "<c-o>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			--
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			vim.g.loaded_netrwPlugin = 1
		end,
	},
}
