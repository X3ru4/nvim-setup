return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	config = function()
		vim.lsp.inlay_hint.enable(true)
		local server = {
			-- Lua
			lua_ls = {},
			-- C/C++
			clangd = {},
		}

		for name, opts in pairs(server) do
			vim.lsp.config(name, opts)
			vim.lsp.enable(name)
		end
	end
}
