return {
	"nvim-mini/mini.tabline",
	version = false,
	event = "VeryLazy",
	opts = {
		always_show = false,
		tabpage_section = "left",

		format = function(bufnr, label)
			local current_buf = vim.api.nvim_get_current_buf() == bufnr
			local modify_icon = require("config.icons").icons.modified
			local file_icon = require("mini.icons").get("file", label)
			local suffix = vim.bo[bufnr].modified and " " .. modify_icon .. "" or ""
			local str = table.concat({
				current_buf and "› " or " ",
				string.format("%s %s%s%s", file_icon, label, suffix, ""),
				current_buf and " ‹" or " ",
			})

			return str
		end,
	},
}
