return {

	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{
				"onsails/lspkind.nvim",
			},
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip").setup()
					require("luasnip.loaders.from_vscode").lazy_load()

					local luasnip = require("luasnip")

					vim.keymap.set({ "i", "s" }, "<Tab>", function()
						if luasnip.expand_or_jumpable() then
							return "<Plug>luasnip-expand-or-jump"
						else
							return "<Tab>"
						end
					end, { expr = true, silent = true })

					vim.keymap.set({ "i", "s" }, "<C-h>", function()
						if luasnip.jumpable(-1) then
							return "<Plug>luasnip-jump-prev"
						else
							return "<C-b>"
						end
					end, { expr = true, silent = true })
				end,
			},
			{
				enabled = vim.g.enable_plugin.lazydev_nvim,
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
				},
				cmdline = {
					enabled = true,
					keymap = {
						preset = "default",
					},
					completion = { menu = { auto_show = true } },
				},
				appearance = {
					nerd_font_variant = "mono",
				},
				signature = { enabled = false },
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
						auto_show = true,
						window = {
							scrollbar = false,
							min_width = 10,
							max_width = 30,
							max_height = 10,
							winblend = 20,
							border = "rounded",
							winhighlight = "CursorLine:BlinkCmpDocCursorLine,Search:None",
						},
					},
					menu = {
						scrollbar = false,
						min_width = 1,
						max_height = 8,
						winblend = 20,
						border = "rounded",
						winhighlight = "CursorLine:BlinkCmpMenuSelection,Search:None",
						draw = {
							columns = {
								{ "kind_icon", "label", "label_description", gap = 1 },
								{ "kind" },
							},
							components = {
								label = {
									width = { fill = true, max = 30 },
								},
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										local lspkind = require("lspkind")
										local icon = ctx.kind_icon
										if vim.tbl_contains({ "Path" }, ctx.source_name) then
											local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
											if dev_icon then
												icon = dev_icon
											end
										else
											icon = require("lspkind").symbolic(ctx.kind, {
												mode = "symbol",
											})
										end
										return icon .. ctx.icon_gap
									end,
								},
							},
							treesitter = { "lsp" },
						},
					},
				},
				snippets = {
					preset = "luasnip",
				},
				sources = vim.g.enable_plugin.lazydev_nvim and {
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
