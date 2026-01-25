return {

	{
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
						hidden = "hidden",
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
					["hl"] = { "fg", "Comment" },
					["fg+"] = { "fg", "Normal" },
					["bg+"] = { "bg", { "CursorLine", "Normal" } },
					["hl+"] = { "fg", "Statement" },
					["info"] = { "fg", "PreProc" },
					["prompt"] = { "fg", "Conditional" },
					["pointer"] = { "fg", "Exception" },
					["marker"] = { "fg", "Keyword" },
					["spinner"] = { "fg", "Label" },
					["header"] = { "fg", "Comment" },
					-- ["gutter"] = "-1",
				},
				colorschemes = {
					prompt = " ",
					actions = {
						["enter"] = function(selected, opts)
							require("fzf-lua.actions").colorscheme(selected, opts)
							vim.cmd("Reloadhl")
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
				},
				buffers = {
					prompt = default_prompt,
					filename_only = true,
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
					winopts = { preview = { hidden = false } },
				},
				quickfix = {
					winopts = { preview = { hidden = false } },
				},
				lsp = {
					prompt = default_prompt,
					winopts = { preview = { hidden = false } },
				},
			})
		end,
		keys = function()
			local fzf = require("fzf-lua")
			return {

				-- <leader>c group

				{
					"<leader>cs",
					fzf.spell_suggest,
					desc = "Spell suggest",
				},

				{
					"<leader>cq",
					fzf.quickfix,
					desc = "Quickfix",
				},

				{
					"<leader>cd",
					fzf.awesome_colorschemes,
					desc = "Download colorschemes",
				},

				{
					"<leader>cc",
					fzf.colorschemes,
					desc = "Change colorscheme",
				},

				{
					"<leader>cgh",
					fzf.git_hunks,
					desc = "Git hunks",
				},

				{
					"<leader>cgd",
					fzf.git_diff,
					desc = "Git diff",
				},

				-- <leader>f group

				{
					"<leader>fr",
					fzf.registers,
					desc = "Find register",
				},

				{
					"<leader>ff",
					fzf.files,
					desc = "Find file CWD",
				},

				{
					"<leader>fF",
					function()
						fzf.files({
							cwd = vim.fn.expand("%:h"),
						})
					end,
					desc = "Find file",
				},

				{
					"<leader>fc",
					function()
						fzf.files({
							cwd = "~/.config/nvim",
						})
					end,
					desc = "Find config files",
				},

				{
					"<leader>fb",
					fzf.buffers,
					desc = "Find buffers",
				},

				{
					"<leader>fh",
					fzf.highlights,
					desc = "Find highlights",
				},

				{
					"<leader>fd",
					fzf.diagnostics_document,
					desc = "Find diagnostics",
				},

				{
					"<leader>fo",
					fzf.oldfiles,
					desc = "Find old files",
				},

				{
					"<leader>ft",
					fzf.filetypes,
					desc = "Find filetypes",
				},

				{
					"<leader>fg",
					fzf.live_grep,
					desc = "Live grep",
				},
			}
		end,
	},
}
