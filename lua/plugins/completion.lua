return {

	{

		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		build = "cargo build --release",
		version = "1.*",
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
			{
				"giuxtaposition/blink-cmp-copilot",
			},
		},
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
					-- ["<Tab>"] = { "snippet_forward", "fallback" },
					["<C-h>"] = { "snippet_backward", "fallback" },
					["<Tab>"] = {
						function(cmp)
							if vim.b[vim.api.nvim_get_current_buf()].nes_state then
								cmp.hide()
								return (
									require("copilot-lsp.nes").apply_pending_nes()
									and require("copilot-lsp.nes").walk_cursor_end_edit()
								)
							end
							if cmp.snippet_active() then
								return cmp.accept()
							else
								return cmp.select_and_accept()
							end
						end,
						"snippet_forward",
						"fallback",
					},
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
							min_width = 30,
							max_width = 45,
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
				sources = {
					default = { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" },
					providers = {
						lazydev = {
							name = "LazyDev",
							module = "lazydev.integrations.blink",
							enabled = true,
							score_offset = 100,
						},
						copilot = {
							name = "copilot",
							module = "blink-cmp-copilot",
							score_offset = 75,
							async = true,
							transform_items = function(_, items)
								local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
								local kind_idx = #CompletionItemKind + 1
								CompletionItemKind[kind_idx] = "Copilot"
								for _, item in ipairs(items) do
									item.kind = kind_idx
								end
								return items
							end,
						},

						-- Built-in sources
						lsp = {
							score_offset = 90,
						},
						path = {
							score_offset = 80,
						},
						snippets = {
							score_offset = 70,
						},
						buffer = {
							score_offset = 60,
						},
					},
				},
			})
		end,
	},
}
