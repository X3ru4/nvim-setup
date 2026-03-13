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
          local kind = require("config.icons").kind
					require("dropbar").setup({
						icons = {
							ui = {
								bar = {
									separator = "  ",
									extends = "…",
								},
							},
							kinds = {
								dir_icon = function(path)
                  local icon, hl = MiniIcons.get("directory", path)
                  return icon .. " ", hl
                end,
								file_icon = function(path)
									local icon, hl = MiniIcons.get("file", path)
									return icon .. " ", hl
								end,
								symbols = {
									Array = " ",
									BlockMappingPair = "󰅩 ",
									Boolean = " ",
									BreakStatement = "󰙧 ",
									Call = " ",
									CaseStatement = "󱃙 ",
									Class = " ",
									Color = " ",
									Constant = " ",
									Constructor = " ",
									ContinueStatement = "→ ",
									Copilot = " ",
									Declaration = "󰙠 ",
									Delete = "󰩺 ",
									DoStatement = "󰑖 ",
									Element = "󰅩 ",
									Enum = " ",
									EnumMember = " ",
									Event = " ",
									Field = " ",
									File = "󰈔 ",
									Folder = "󰉋 ",
									ForStatement = "󰑖 ",
									Function = "󰊕 ",
									GotoStatement = "󰁔 ",
									Identifier = " ",
									IfStatement = "󰇉 ",
									Interface = " ",
									Keyword = " ",
									List = " ",
									Log = "󰦪 ",
									Lsp = " ",
									Macro = "󰁌 ",
									MarkdownH1 = "󰉫 ",
									MarkdownH2 = "󰉬 ",
									MarkdownH3 = "󰉭 ",
									MarkdownH4 = "󰉮 ",
									MarkdownH5 = "󰉯 ",
									MarkdownH6 = "󰉰 ",
									Method = " ",
									Module = "󰏗 ",
									Namespace = "󰅩 ",
									Null = "󰢤 ",
									Number = "󰎠 ",
									Object = "󰅩 ",
									Operator = "󰆕 ",
									Package = "󰏗 ",
									Pair = "󰅪 ",
									Property = " ",
									Reference = "󰦾 ",
									Regex = " ",
									Repeat = "󰑖 ",
									Return = "󰌑 ",
									Rule = "󰅩 ",
									RuleSet = "󰅩 ",
									Scope = "󰅩 ",
									Section = "󰅩 ",
									Snippet = "󰩫 ",
									Specifier = "󰦪 ",
									Statement = "󰅩 ",
									String = "󰉾 ",
									Struct = " ",
									SwitchStatement = "󰺟 ",
									Table = "󰅩 ",
									Terminal = " ",
									Text = " ",
									Type = " ",
									TypeParameter = "󰆩 ",
									Unit = " ",
									Value = "󰎠 ",
									Variable = " ",
									WhileStatement = "󰑖 ",
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
							keymaps = {
								["<BS>"] = "<C-w>q",
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
				{ "-;", api.goto_context_start, desc = "Go to start of current context" },
				{ "+;", api.select_next_context, desc = "Select next context" },
			}
		end,
	},
}
