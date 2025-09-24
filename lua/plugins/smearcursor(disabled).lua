return {
	enabled = false,
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	opts = {
		smear_insert_mode = false,
		cursor_color = "#aabf05",
		stiffness = 0.4,
		trailing_stiffness = 0.1,
		damping = 0.3,
		trailing_exponent = 5,
		never_draw_over_target = true,
		hide_target_hack = true,
		matrix_pixel_threshold = 0.5,
		gamma = 1,
		time_interval = 17,
	},
}
