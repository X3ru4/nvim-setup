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
				"fang2hou/blink-copilot",
				opts = {
					max_completions = 3,
					max_attempts = 2,
					kind_name = "Copilot", ---@type string | false
					kind_icon = require("config.icons").kind.Copilot, ---@type string | false
					kind_hl = "BlinkCmpKindEvent", ---@type string | false
					debounce = 200, ---@type integer | false
					auto_refresh = {
						backward = true,
						forward = true,
					},
				},
			},
		},
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
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
					use_nvim_cmp_as_default = vim.g.blinkcmp_cmphl or false,
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
							border = "rounded",
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
					},
					menu = {
						scrollbar = false,
						min_width = 1,
						max_height = 8,
						winblend = 0,
						border = vim.g.blinkcmp_border or "rounded",
						winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
						draw = {
							gap = 1,
							padding = { 1, 1 },
							align_to = "label",
							columns = {
								{ "kind_icon" },
								{
									"label",
									-- "label_description",
									"kind",
									gap = 1,
								},
							},
							components = {
								label = {
									width = { fill = true, max = 30 },
								},
								kind = {
									width = { fill = false },
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
							module = "blink-copilot",
							enabled = vim.g.plugin.ai,
							score_offset = 75,
							async = true,
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
