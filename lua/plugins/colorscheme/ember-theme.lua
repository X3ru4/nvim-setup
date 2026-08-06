return {
	'ember-theme/nvim',
	name = 'ember',
	priority = 1000,
	config = function()
		require('ember').setup({
			variant = 'ember-light', -- "ember" | "ember-soft" | "ember-light"
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = { bold = true },
				types = { bold = true },
			},
			dark_variant = 'ember', -- used by `ember-auto` when background = "dark"
			light_variant = 'ember-light',
		})
		vim.cmd.colorscheme('ember-auto')
	end,
}
