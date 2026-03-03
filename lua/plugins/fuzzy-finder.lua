return {

	{
		-- Disable this plugin may cause some issues.
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		config = function()
			local default_prompt = "› "
			require("fzf-lua").setup({
				file_icon_padding = " ",
				keymap = {
					-- Below are the default binds, setting any value in these tables will override
					-- the defaults, to inherit from the defaults change [1] from `false` to `true`
					builtin = {
						-- neovim `:tmap` mappings for the fzf win
						-- true,        -- uncomment to inherit all the below in your custom config
						["<M-Esc>"] = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
						["<F1>"] = "toggle-help",
						["<F2>"] = "toggle-fullscreen",
						-- Only valid with the 'builtin' previewer
						["<C-w>"] = "toggle-preview-wrap",
						["<C-p>"] = "toggle-preview",
						-- Rotate preview clockwise/counter-clockwise
						["<F5>"] = "toggle-preview-cw",
						-- Preview toggle behavior default/extend
						["<F6>"] = "toggle-preview-behavior",
						-- `ts-ctx` binds require `nvim-treesitter-context`
						["<F7>"] = "toggle-preview-ts-ctx",
						["<F8>"] = "preview-ts-ctx-dec",
						["<F9>"] = "preview-ts-ctx-inc",
						["<S-Left>"] = "preview-reset",
						["<S-down>"] = "preview-page-down",
						["<S-up>"] = "preview-page-up",
						["<M-C-down>"] = "preview-down",
						["<M-C-up>"] = "preview-up",
					},
					fzf = {
						-- fzf '--bind=' options
						-- true,        -- uncomment to inherit all the below in your custom config
						["ctrl-z"] = "abort",
						["ctrl-u"] = "unix-line-discard",
						["ctrl-f"] = "half-page-down",
						["ctrl-b"] = "half-page-up",
						["ctrl-a"] = "beginning-of-line",
						["ctrl-e"] = "end-of-line",
						["alt-a"] = "toggle-all",
						["alt-g"] = "first",
						["alt-G"] = "last",
						-- Only valid with fzf previewers (bat/cat/git/etc)
						["f3"] = "toggle-preview-wrap",
						["f4"] = "toggle-preview",
						["shift-down"] = "preview-page-down",
						["shift-up"] = "preview-page-up",
					},
				},
				winopts = {
					preview = {
						wrap = true,
						hidden = true,
					},
					row = 0.4,
					backdrop = 60,
					treesitter = {
						enabled = false,
					},
					fullscreen = true,
				},
				fzf_colors = {
					true, -- inherit fzf colors that aren't specified below from
					-- the auto-generated theme similar to `fzf_colors=true`
					["fg"] = { "fg", "CursorLine" },
					["bg"] = { "bg", "Normal" },
					["hl"] = { "fg", "Statement", "bold" },
					["fg+"] = { "fg", "Normal" },
					["bg+"] = { "bg", { "CursorLine", "Normal" } },
					["hl+"] = { "fg", "Statement", "bold" },
					["info"] = { "fg", "PreProc", "bold" },
					["prompt"] = { "fg", "Conditional" },
					["pointer"] = { "fg", "Exception" },
					["marker"] = { "fg", "Keyword" },
					["spinner"] = { "fg", "Label" },
					["header"] = { "fg", "Comment" },
					["gutter"] = "0",
				},
				colorschemes = {
					prompt = " ",
					actions = {
						["enter"] = function(selected, opts)
							require("fzf-lua.actions").colorscheme(selected, opts)
							vim.cmd("SetupHl")
						end,
					},
				},
				awesome_colorschemes = {
					prompt = " ",
				},
				spell_suggest = {
					prompt = default_prompt,
				},
				registers = {
					prompt = " ",
					winopts = { preview = { hidden = false } },
				},
				buffers = {
					prompt = default_prompt,
					filename_only = true,
					winopts = { preview = { hidden = false } },
				},
				tabs = {
					prompt = default_prompt,
					winopts = { preview = { hidden = false } },
				},
				highlights = {
					prompt = default_prompt,
					winopts = { preview = { hidden = false } },
				},
				diagnostics = {
					prompt = default_prompt,
					winopts = { preview = { hidden = false } },
				},
				oldfiles = {
					prompt = default_prompt,
					cwd_only = true,
				},
				grep = {
					winopts = { preview = { hidden = false } },
				},
				git = {
					diff = {
						winopts = { preview = { hidden = false } },
					},
					hunks = {
						winopts = { preview = { hidden = false } },
					},
				},
				quickfix = {
					winopts = { preview = { hidden = false } },
				},
				lsp = {
					prompt = default_prompt,
					winopts = { preview = { hidden = false } },
					symbols = {
						-- lsp_query      = "foo"       -- query passed to the LSP directly
						-- query          = "bar"       -- query passed to fzf prompt for fuzzy matching
						locate = false, -- attempt to position cursor at current symbol
						async_or_timeout = true, -- symbols are async by default
						symbol_style = 1, -- style for document/workspace symbols
						-- false: disable,    1: icon+kind
						--     2: icon only,  3: kind only
						-- NOTE: icons are extracted from
						-- vim.lsp.protocol.CompletionItemKind
						-- icons for symbol kind
						-- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
						-- see https://github.com/neovim/neovim/blob/829d92eca3d72a701adc6e6aa17ccd9fe2082479/runtime/lua/vim/lsp/protocol.lua#L117
						symbol_icons = {
							File = "",
							Module = "",
							Namespace = "",
							Package = "",
							Class = "",
							Method = "",
							Property = "",
							Field = "",
							Constructor = "󰢻",
							Enum = "",
							Interface = "",
							Function = "󰊕",
							Variable = "",
							Constant = "",
							String = "",
							Number = "",
							Boolean = "",
							Array = "",
							Object = "",
							Key = "",
							Null = "",
							EnumMember = "",
							Struct = "",
							Event = "",
							Operator = "",
							TypeParameter = "",
						},
						-- colorize using Treesitter '@' highlight groups ("@function", etc).
						-- or 'false' to disable highlighting
						symbol_hl = function(s)
							local hl = {
								object = "@type.builtin",
								array = "@type.builtin",
                struct = "BlinkCmpKindStruct",
                variable = "BlinkCmpKindVariable",
                package = "BlinkCmpKindModule",
                interface = "BlinkCmpKindInterface",
							}
							s = s:lower()
							if hl[s] then
								return hl[s]
							end
              return "@" .. s
						end,
						-- additional symbol formatting, works with or without style
						symbol_fmt = function(s, opts)
							return "⟨" .. s .. "⟩"
						end,
					},
				},
			})
			local fzf = require("fzf-lua")
			local keymap = vim.keymap.set
			local mode = "n"

			-- <leader>c group
			keymap(mode, "<leader>cs", fzf.spell_suggest, { desc = "Spell suggest" })
			keymap(mode, "<leader>cq", fzf.quickfix, { desc = "Quickfix" })
			-- keymap(mode, "<leader>cp", fzf.awesome_colorschemes, { desc = "Download colorschemes" })
			keymap(mode, "<leader>cl", fzf.lsp_document_symbols, { desc = "Lsp sumbols" })
			keymap(mode, "<leader>cd", fzf.diagnostics_document, { desc = "All diagnostics" })
			keymap(mode, "<leader>cc", fzf.colorschemes, { desc = "Change colorscheme" })
			keymap(mode, "<leader>cgh", fzf.git_hunks, { desc = "Git hunks" })
			keymap(mode, "<leader>cgd", fzf.git_diff, { desc = "Git diff" })

			-- <leader>f group
			keymap(mode, "<leader>fr", fzf.registers, { desc = "Find register" })
			keymap(mode, "<leader>ff", fzf.files, { desc = "Find file CWD" })
			keymap(mode, "<leader>fF", function()
				fzf.files({
					cwd = vim.fn.expand("%:h"),
				})
			end, { desc = "Find file" })
			keymap(mode, "<leader>fc", function()
				fzf.files({
					cwd = "~/.config/nvim",
				})
			end, { desc = "Find config files" })
			keymap(mode, "<leader>fb", fzf.buffers, { desc = "Find buffers" })
			keymap(mode, "<leader>ft", fzf.tabs, { desc = "Find tabs" })
			keymap(mode, "<leader>fh", fzf.highlights, { desc = "Find highlights" })
			keymap(mode, "<leader>fo", fzf.oldfiles, { desc = "Find old files" })
			keymap(mode, "<leader>fT", fzf.filetypes, { desc = "Find filetypes" })
			keymap(mode, "<leader>fg", fzf.live_grep, { desc = "Live grep" })
		end,
	},
}
