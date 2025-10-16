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

				{
					"<leader>fg",
					function()
						fzf.live_grep()
					end,
					desc = "Live grep",
				},
			}
		end,
	},

	{
		enabled = false,
		"royanirudd/clipboard-history.nvim",
		opts = {
			max_history = 20, -- Optional: set max history (default 100)
			enable_wsl_features = false, -- Set to true if you're using WSL and want Windows clipboard integration
		},
		keys = {
			{ "<leader>p", "<CMD>ClipboardHistory<CR>" },
		},
	},

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

	{
		"ziontee113/icon-picker.nvim",
		opts = {
			disable_legacy_commands = true,
		},
		keys = {
			{ "<Leader>fi", "<cmd>IconPickerNormal<cr>", noremap = true, silent = true, desc = "Pick icon" },
			{ "<Leader>fiy", "<cmd>IconPickerYank<cr>", noremap = true, silent = true, desc = "Yank icon" },
			{ mode = "i", "<C-z>", "<cmd>IconPickerInsert<cr>", noremap = true, silent = true },
		},
	},

	{
		enabled = false,
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			{ "ibhagwan/fzf-lua" },
		},
		config = function()
			require("neoclip").setup({
				history = 20,
				enable_persistent_history = true,
				length_limit = 1048576,
				keys = {
					fzf = {
						select = "default",
						paste = "space",
						paste_behind = "ctrl-k",
						custom = {},
					},
				},
			})
		end,
		keys = {
			{
				"<leader>p",
				function()
					require("neoclip.fzf")("0")
				end,
				desc = "Yank history",
			},
		},
	},

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

			require("oil").setup({
				win_options = {
					winbar = "%!v:lua.get_oil_winbar()",
				},
				keymaps = {
					["<C-s>"] = {},
					["<C-h>"] = nil,
					["g."] = nil,
					["-"] = nil,
					["<leader>ff"] = {
						function()
							vim.cmd("FZF " .. require("oil").get_current_dir(0))
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

	{
		enabled = false,
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		dependencies = "kevinhwang91/promise-async",
		opts = {
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				vim.o.foldenable = true
				vim.o.foldcolumn = "1"
				return newVirtText
			end,
		},
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
			},
		},
	},

	{
		"folke/persistence.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>qS",
				function()
					require("persistence").select()
				end,
				desc = "Select Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			win = {
				no_overlap = true,
				width = 20,
				height = { min = 4, max = 10 },
				-- col = 0,
				-- row = 0,
				border = "rounded",
				padding = { 1, 1 },
				title = true,
				title_pos = "left",
				zindex = 1000,
				bo = {},
				wo = {
					-- winblend = 20,
				},
			},
		},
		keys = {
			{
				"<leader><leader>",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		enabled = false,
		"gbprod/yanky.nvim",
		opts = {
			ring = { storage = "shada" },
			picker = {
				select = {
					action = nil, -- nil to use default put action
				},
				telescope = {
					mappings = nil, -- nil to use default mappings
				},
			},
			highlight = {
				on_put = true,
				on_yank = false,
				timer = 150,
			},
		},
		keys = {
			{ "<leader>p", "<cmd>YankyRingHistory<cr>", mode = { "n", "x" }, desc = "Open Yank History" },
			{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
			{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
			{ "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
			{ "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
			{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
			{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
			{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
			{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
			{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
			{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
			{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
			{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
		},
	},
}
