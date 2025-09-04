return {
	enabled = false,
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		local diagnostic = require("config.icons").diagnostic
		local diag_ = {
			"diagnostics",
			update_in_insert = false,
			symbols = {
				error = diagnostic.errr .. " ",
				warn = diagnostic.warn .. " ",
				info = diagnostic.info .. " ",
				hint = diagnostic.hint .. " ",
			},
		}
		return {
			options = {
				theme = "auto",
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
				},
				component_separators = {
					left = "",
					right = "|",
				},
				section_separators = {
					left = "",
					right = "",
				},
				always_show_tabline = false,
				refresh = {
					tabline = nil,
					winbar = nil,
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
						padding = { left = 1, right = 0 },
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{
						"filetype",
						padding = { left = 1, right = 1 },
						fmt = function()
							return ""
						end,
						icon_only = false,
					},
					{
						"filename",
						padding = { left = 0, right = 1 },
						shorting_target = 10,
						symbols = {
							modified = require("config.icons").icons.modified,
							readonly = "",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					diag_,
				},
				lualine_z = {
					{
						function()
							return " 𝙓𝝐𝖗𝖚𝜶"
						end,
						padding = { left = 0, right = 1 },
						separator = { left = "", right = "" },
					},
				},
			},
			inactive_sections = {},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		}
	end,
}
