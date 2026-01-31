return {

	{
		"rebelot/heirline.nvim",
		-- You can optionally lazy-load heirline on UiEnter
		-- to make sure all required plugins and colorschemes are loaded before setup
		event = "UiEnter",
		config = function()
			require("heirline").setup(require("config.heirline").config)
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
		event = "VeryLazy",
		lazy = false,
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
				separator = { left = "", right = "" },
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
							separator = { left = "", right = "" },
							padding = { left = 0, right = 0 },
							fmt = function(str)
								return str:sub(1, 3)
							end,
						},
					},
					lualine_b = {
						{
							"filetype",
							padding = { left = 1, right = 0 },
							fmt = function()
								return ""
							end,
							icon_only = false,
						},
						{
							function()
								return table.concat({
									vim.bo.filetype,
									vim.bo.modified and " 󰧞" or "",
								})
							end,
						},
						-- {
						-- 	"filename",
						-- 	padding = { left = 1, right = 1 },
						-- 	shorting_target = 10,
						-- 	symbols = {
						-- 		modified = require("config.icons").icons.modified,
						-- 		readonly = "",
						-- 		unnamed = "[No Name]",
						-- 		newfile = "[New]",
						-- 	},
						-- },
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {
						diag_,
					},
					lualine_z = {
						-- {
						-- 	"location",
						-- 	padding = { left = 0, right = 0 },
						-- 	separator = { left = "", right = "" },
						-- },
					},
				},
				inactive_sections = {},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}
		end,
	},
}
