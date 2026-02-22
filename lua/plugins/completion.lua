return {

	{

		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				enabled = true,
				dependencies = { "rafamadriz/friendly-snippets" },
				build = "make install_jsregexp",
				config = function()
					require("luasnip").setup()
					require("luasnip.loaders.from_vscode").lazy_load()

					local ls = require("luasnip")

					vim.keymap.set({ "i", "s" }, "<Tab>", function()
						if ls.expand_or_jumpable() then
							return "<Plug>luasnip-expand-or-jump"
						else
							return "<Tab>"
						end
					end, { expr = true, silent = true })

					vim.keymap.set({ "i", "s" }, "<C-h>", function()
						if ls.jumpable(-1) then
							return "<Plug>luasnip-jump-prev"
						else
							return "<C-h>"
						end
					end, { expr = true, silent = true })
				end,
			},
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		version = "1.*",
		config = function()
			vim.lsp.config("*", {
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					require("blink.cmp").get_lsp_capabilities()
				),
			})
			require("blink-cmp").setup({
				keymap = {
					preset = "enter",
					["<C-x>"] = { "hide_documentation", "fallback" },
				},
				cmdline = {
					enabled = true,
					keymap = {
						preset = "default",
					},
					completion = { menu = { auto_show = true } },
				},
				appearance = {
          ---@type "mono"|"normal"
					nerd_font_variant = "normal",
					kind_icons = {
						Text = "",
						Method = "",
						Function = "󰊕",
						Constructor = "󰢻",

						Field = "",
						Variable = "",
						Property = "",

						Class = "",
						Interface = "",
						Struct = "",
						Module = "󰅩",

						Unit = "",
						Value = "",
						Enum = "",
						EnumMember = "",

						Keyword = "",
						Constant = "",

						Snippet = "",
						Color = "",
						File = "",
						Reference = "",
						Folder = "",
						Event = "",
						Operator = "",
						TypeParameter = "",
					},
				},
				signature = {
					enabled = false,
					window = {
						scrollbar = false,
						winblend = 0,
						border = "rounded",
            show_documentation = false,
					},
				},
				completion = {
					ghost_text = {
						enabled = true,
					},
					accept = {
						auto_brackets = {
							enabled = true,
						},
					},
					documentation = {
						auto_show = false,
						window = {
							scrollbar = false,
							min_width = 15,
							max_width = 30,
							max_height = 10,
							winblend = 0,
							border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
					},
					menu = {
						scrollbar = false,
						min_width = 1,
						max_height = 8,
						winblend = 0,
						-- border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
						border = vim.g.blinkcmp_border or "rounded",
						winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
						draw = {
							columns = {
								{
									"kind_icon",
									"label",
									"kind",
									-- "label_description",
									gap = 1,
								},
							},
							padding = { 1, 1 },
							components = {
								label = {
									width = { fill = true, max = 30 },
								},
							},
							treesitter = { "lsp" },
						},
					},
				},
				snippets = {
					preset = "luasnip",
				},
				sources = require("utility.lazy").is_loaded("lazydev.nvim") and {
					default = { "lazydev", "lsp", "path", "snippets", "buffer" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							score_offset = 100,
						},
					},
				} or {},
			})
		end,
	},
}
