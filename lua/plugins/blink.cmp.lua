return {
	'saghen/blink.cmp',
	event = { 'InsertEnter', 'CmdlineEnter' },
	version = '1.*',
	dependencies = {
		{ 'rafamadriz/friendly-snippets' },
		{
			'folke/lazydev.nvim',
			ft = 'lua',
			opts = {
				library = {
					{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
				},
			},
		},
	},
	config = function()
		local blinkcmp = require('config.extra_options').blinkcmp

		require('blink-cmp').setup({
			keymap = {
				preset = 'enter',
				['<Tab>'] = { 'snippet_forward', 'fallback' },
				['<C-h>'] = { 'snippet_backward', 'fallback' },
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = 'default',
					['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
					['<S-Tab>'] = { 'show_and_insert_or_accept_single', 'select_prev' },
				},
				completion = {
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ':'
							-- enable for inputs as well, with:
							-- or vim.fn.getcmdtype() == '@'
						end,
					},
				},
			},
			appearance = {
				use_nvim_cmp_as_default = blinkcmp.appearance.use_nvimcmp_hl,
				---@type "mono"|"normal"
				nerd_font_variant = 'normal',
				kind_icons = {
					Text = '',
					Method = '',
					Function = '',
					Constructor = '',

					Field = '',
					Variable = '󰫧',
					Property = '',

					Class = '',
					Interface = '',
					Struct = '',
					Module = '',

					Unit = '',
					Value = '',
					Enum = '',
					EnumMember = '',

					Keyword = '',
					Constant = '󰏿',

					Snippet = '󰒉',
					Color = '',
					File = '',
					Folder = '',
					Reference = '',
					Event = '',
					Operator = '',
					TypeParameter = '',
				},
			},
			signature = { enabled = false },
			completion = {
				ghost_text = { enabled = false },
				accept = { auto_brackets = { enabled = true } },
				documentation = {
					auto_show = blinkcmp.documentation.auto_show,
					auto_show_delay_ms = 500,
					treesitter_highlighting = true,
					window = {
						scrollbar = false,
						min_width = 30,
						max_width = 45,
						max_height = 10,
						border = blinkcmp.documentation.border,
					},
				},
				menu = {
					scrollbar = false,
					min_width = 4,
					max_height = 8,
					border = blinkcmp.menu.border,
					draw = {
						columns = { { 'kind_icon' }, { 'label', 'kind', gap = 1 } },
						components = {
							label = {
								width = { fill = true, max = 30 },
							},
							kind = {
								width = { fill = false },
							},
						},
						treesitter = { 'lsp' },
					},
				},
			},
			sources = {
				default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
				providers = {
					lazydev = {
						name = 'LazyDev',
						module = 'lazydev.integrations.blink',
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
