return {
	enabled = false,
	"rachartier/tiny-glimmer.nvim",
	event = "VeryLazy",
	priority = 10,
	opts = {
		overwrite = {
			auto_map = true,
			yank = {
				enabled = true,
				default_animation = "fade",
			},
			paste = {
				enabled = true,
				default_animation = "fade",
				paste_mapping = "p",
				Paste_mapping = "P",
			},
			undo = {
				enabled = true,

				default_animation = {
					name = "fade",

					settings = {
						from_color = "DiffDelete",

						max_duration = 500,
						min_duration = 500,
					},
				},
				undo_mapping = "u",
			},
			redo = {
				enabled = true,

				default_animation = {
					name = "fade",
					settings = {
						from_color = "DiffAdd",
						max_duration = 500,
						min_duration = 500,
					},
				},
				redo_mapping = "<c-r>",
			},
		},

		animations = {
			fade = {
				max_duration = 400,
				min_duration = 300,
				easing = "inOutQuad",
				chars_for_max_duration = 10,
				from_color = "PmenuSel", -- Highlight group or hex color
				to_color = "Normal", -- Same as above
			},
		},
	},
}
