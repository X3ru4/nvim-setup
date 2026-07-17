return {
	"nvim-mini/mini.indentscope",
	enabled = true,
	version = false,
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		return {
			draw = {
				delay = 40,
			},
			mappings = {
				object_scope = "ii",
				object_scope_with_border = "ai",
				goto_top = "-i",
				goto_bottom = "+i",
			},
			options = {
				border = "both",
				indent_at_cursor = true,
				n_lines = 100,
				try_as_border = true,
			},
			symbol = "▎",
		}
	end,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"fzf",
				"help",
				"lazy",
				"mason",
				"oil",
				"oil_preview",
				"dropbar_menu",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
