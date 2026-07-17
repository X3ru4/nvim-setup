return {

	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	build = "cargo build --release",
	version = "1.*",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
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
	config = function()
    local blinkcmp = require("config.extra_options").blinkcmp

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
				use_nvim_cmp_as_default = blinkcmp.appearance.use_nvimcmp_hl,
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
					auto_show = blinkcmp.documentation.auto_show,
					auto_show_delay_ms = 500,
					treesitter_highlighting = true,
					window = {
						scrollbar = false,
						min_width = 30,
						max_width = 45,
						max_height = 10,
						winblend = 0,
						border = blinkcmp.documentation.border,
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					},
				},
				menu = {
					scrollbar = false,
					min_width = 1,
					max_height = 8,
					winblend = 0,
					border = blinkcmp.menu.border,
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
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						enabled = true,
						score_offset = 100,
					},
					lsp = {
						score_offset = 90,
					},
					path = {
						score_offset = 80,
					},
					snippets = {
						score_offset = 70,
						opts = {
							friendly_snippets = true, -- ensure friendly-snippets is enabled
						},
					},
					buffer = {
						score_offset = 60,
					},
				},
			},
		})
	end,
}
