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
					["<Tab>"] = { "snippet_forward", "fallback" },
					["<C-h>"] = { "snippet_backward", "fallback" },
				},
				cmdline = {
					enabled = true,
					keymap = {
						preset = "default",
						["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
						["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
					},
					completion = {
						menu = {
							auto_show = function(ctx)
								return vim.fn.getcmdtype() == ":"
								-- enable for inputs as well, with:
								-- or vim.fn.getcmdtype() == '@'
							end,
						},
					},
				},
				appearance = {
					use_nvim_cmp_as_default = false,
					---@type "mono"|"normal"
					nerd_font_variant = "normal",
					kind_icons = require("config.icons").kind,
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
						show_with_selection = true,
						show_without_selection = true,
						show_with_menu = true,
						show_without_menu = true,
					},
					accept = {
						auto_brackets = {
							enabled = true,
						},
					},
					documentation = {
						auto_show = false,
						auto_show_delay_ms = 500,
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
									-- "label_description",
									"kind",
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
				snippets = { preset = "luasnip" },
				sources = require("utility.lazy").plugin_loaded("lazydev.nvim")
						and {
							default = { "lazydev", "lsp", "path", "snippets", "buffer" },
							providers = {
								lazydev = {
									name = "LazyDev",
									module = "lazydev.integrations.blink",
									score_offset = 100,
								},
							},
						}
					or {},
			})
		end,
	},
}
