return {
	"sainnhe/gruvbox-material",
	name = "gruvbox-material",
	config = function()
		-- vim.o.background = "light"

		vim.g.gruvbox_material_transparent_background = false
		vim.g.gruvbox_material_enable_bold = true
		vim.g.gruvbox_material_enable_italic = false
		vim.g.gruvbox_material_disable_italic_comment = true
		-- Available values 'grey background'|"green background"|"blue background"|"red background"|"reverse"
		vim.g.gruvbox_material_visual = "green background"
		-- Available values "material"|"mix"|"original"
		vim.g.gruvbox_material_foreground = "original"
		-- Available values "hard"|"medium"|"soft"
		vim.g.gruvbox_material_background = "soft"
		vim.g.gruvbox_material_ui_contrast = "high" -- "low"|"high"
		-- Available values "grey background"|"high contrast background"|"bold"|"underline"|"italic"
		vim.g.gruvbox_material_current_word = "grey background"
		-- Available values "bright"|"dim"|"blend"
		vim.g.gruvbox_material_float_style = "blend"
		-- Available values "grey"|"colored"|"highlighted"
		vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
		vim.g.gruvbox_material_better_performance = 0
		-- Available values "none"|"dimmed"
		vim.g.gruvbox_material_inlay_hints_background = "none"

		vim.cmd.colorscheme("gruvbox-material")
	end,
}
