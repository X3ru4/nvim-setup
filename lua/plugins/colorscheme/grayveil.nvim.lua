return {
	"ZhiWei-Ou/grayveil.nvim",
  name = "grayveil",
	config = function()
		require("grayveil").setup({
			transparent = false,
			terminal_colors = true,
		})
    vim.cmd.colorscheme("grayveil")
	end,
}
