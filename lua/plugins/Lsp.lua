return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.lsp.inlay_hint.enable(true)
		local server = {
			-- Lua
			lua_ls = {},
			-- C/C++
			clangd = {},
			-- Python
			pyright = {},
		}

		for name, opts in pairs(server) do
			vim.lsp.config(name, opts)
			vim.lsp.enable(name)
		end
	end,
}
