return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	config = function()
		local server = {
			-- Lua
			lua_ls = {},
			-- Html
			html = {},
			-- Css
			cssls = {},
			-- TypeScript/JavaScript
			ts_ls = {},
			-- Emmet html
			emmet_language_server = {},
			-- C/C++
			clangd = {},
		}

		for name, opts in pairs(server) do
			vim.lsp.config(name, opts)
			vim.lsp.enable(name)
		end
	end,
}
