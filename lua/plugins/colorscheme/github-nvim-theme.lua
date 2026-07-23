return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	config = function()
		require("github-theme").setup({
			-- ...
		})

		vim.cmd("colorscheme github_dark")
	end,
}
