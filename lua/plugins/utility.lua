return {

	{
		"mvllow/modes.nvim",
		enabled = false,
		event = "BufReadPost",
		tag = "v0.2.1",
		config = function()
			require("modes").setup()
		end,
	},

	{
		"mcauley-penney/visual-whitespace.nvim",
		enabled = false,
		event = "ModeChanged *:[vV\22]",
		opts = {
			enabled = true,
			highlight = { link = "Visual", default = true },
			match_types = {
				space = true,
				tab = false,
				nbsp = true,
				lead = false,
				trail = false,
			},
			list_chars = {
				space = "·",
				tab = " ",
				nbsp = "␣",
				lead = "‹",
				trail = "›",
			},
			fileformat_chars = {
				unix = "↴",
				mac = "←",
				dos = "↙",
			},
		},
	},

	{
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{
				"rcarriga/nvim-notify",
				opts = {
          render = "minimal",
          stages = "fade_in_slide_out",
          max_height = 5,
          max_width = 20,
        },
			},
		},
		opts = {
			-- I don't this cmdline
			cmdline = {
				enabled = true,
				view = "cmdline",
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
				},
			},
			messages = {
				enabled = true,
			},
			popupmenu = { enabled = false },
			commands = {},
			notify = { enabled = true },
			lsp = {
				progress = {
					enabled = false,
					format = "lsp_progress",
					view = "mini",
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false,
				},
				hover = { enabled = false },
				signature = {
					enabled = false,
					auto_open = {
						enabled = false,
						trigger = false,
						luasnip = false,
					},
				},
				documentation = {
					view = "hover",
					opts = {
						lang = "markdown",
						replace = true,
						render = "plain",
						format = { "{message}" },
						win_options = { concealcursor = "n", conceallevel = 3 },
					},
				},
			},
			health = {
				checker = false, -- Disable if you don't want health checks to run
			},
			message = {
				-- Messages shown by lsp servers
				enabled = false,
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = false,
				inc_rename = true,
				lsp_doc_border = false,
			},
		},
	},

	{
		"NStefan002/screenkey.nvim",
		enabled = false,
		event = "VeryLazy",
		version = "*",
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				override = function(conf)
					conf.col = -1
					conf.row = 0
					return conf
				end,
        border = "rounded",
			},
			select = {
				backend = "fzf_lua",
			},
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
}
