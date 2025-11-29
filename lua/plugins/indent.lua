return {

	{
		"saghen/blink.indent",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		--- @module 'blink.indent'
		--- @type blink.indent.Config
		keys = {
			{
				"<leader>ci",
				function()
					require("blink.indent").enable(not require("blink.indent").is_enabled())
				end,
				desc = "Toggle indent guides",
			},
		},
		opts = {
			blocked = {
				-- default: 'terminal', 'quickfix', 'nofile', 'prompt'
				buftypes = { include_defaults = true },
				-- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
				filetypes = { include_defaults = true },
			},
			mappings = {
				-- which lines around the scope are included for 'ai': 'top', 'bottom', 'both', or 'none'
				border = "both",
				-- set to '' to disable
				-- textobjects (e.g. `y2ii` to yank current and outer scope)
				object_scope = "ii",
				object_scope_with_border = "ai",
				-- motions
				goto_top = "[i",
				goto_bottom = "]i",
			},
			static = {
				enabled = true,
				char = "▏",
				whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
				priority = 1,
				highlights = { "BlinkIndent" },
			},
			scope = {
				enabled = true,
				char = "▏",
				priority = 1000,
				highlights = {
					"BlinkIndentRed",
					"BlinkIndentOrange",
					"BlinkIndentYellow",
					"BlinkIndentGreen",
					"BlinkIndentCyan",
					"BlinkIndentBlue",
					"BlinkIndentViolet",
				},
				underline = {
					enabled = false,
					highlights = {
						"BlinkIndentRedUnderline",
						"BlinkIndentOrangeUnderline",
						"BlinkIndentYellowUnderline",
						"BlinkIndentGreenUnderline",
						"BlinkIndentCyanUnderline",
						"BlinkIndentBlueUnderline",
						"BlinkIndentVioletUnderline",
					},
				},
			},
		},
	},

	{
		"shellRaining/hlchunk.nvim",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					priority = 15,
					style = {
						{
							fg = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" }).fg,
							bold = false,
						},
						{
							fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }).fg,
							bold = false,
						},
					},
					use_treesitter = true,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
					error_sign = true,
					-- animation related
					duration = 0,
					delay = 20,
				},
				indent = {
					enable = true,
					use_treesitter = false,
					style = {
						{
							bold = false,
						},
					},
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
			},
			indent = {
				char = "▏",
				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			},
		},
	},
}
