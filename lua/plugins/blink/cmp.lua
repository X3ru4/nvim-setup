return {
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		-- uses mini.icons
		'saghen/blink.cmp',
		build = function()
			require('blink.cmp').build():pwait()
		end,
		dependencies = {
			'saghen/blink.lib',
			'timrydefalk/blink-cmp-emoji',
			'rafamadriz/friendly-snippets',
		},
		event = { 'InsertEnter', 'CmdlineEnter' },
		config = function()
			require('blink.cmp').setup({
				keymap = {
					preset = 'enter',
					['<Tab>'] = { 'snippet_forward', 'fallback' },
					['<C-h>'] = { 'snippet_backward', 'fallback' },
				},
				fuzzy = {
					implementation = 'prefer_rust_with_warning',
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
							auto_show = function()
								return vim.fn.getcmdtype() == ':'
							end,
						},
					},
				},
				appearance = {
					nerd_font_variant = 'normal',
				},
				signature = { enabled = false },
				completion = {
					ghost_text = { enabled = false },
					accept = { auto_brackets = { enabled = true } },
					documentation = {
						auto_show = false,
						auto_show_delay_ms = 500,
						treesitter_highlighting = true,
						window = {
							scrollbar = false,
							border = 'none',
						},
					},
					menu = {
						max_height = 8,
						scrollbar = true,
						border = 'none',
						draw = {
							padding = 1,
							gap = 1,
							columns = { { 'kind_icon' }, { 'label', 'kind', gap = 1 } },
							components = {
								kind_icon = {
									text = function(ctx)
										local kind_icon, _, is_default = MiniIcons.get('lsp', ctx.kind)
										if is_default then
											return ctx.kind_icon .. ctx.icon_gap
										end
										return kind_icon .. ctx.icon_gap
									end,
								},
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
					default = { 'emoji', 'lsp', 'buffer', 'path', 'snippets' },
					per_filetype = {
						lua = { inherit_defaults = true, 'lazydev' },
					},
					providers = {
						lazydev = {
							name = 'LazyDev',
							module = 'lazydev.integrations.blink',
						},
						emoji = {
							module = 'blink-cmp-emoji',
							name = 'blink-cmp-emoji',
							max_items = 10,
							min_keyword_length = 1,
							score_offset = 10,
							opts = {
								trigger = ';;',
							},
						},
					},
				},
			})
		end,
	},
}
