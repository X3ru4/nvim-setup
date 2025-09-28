return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		vim.lsp.inlay_hint.enable(true)
		local server = {
			-- Lua
			lua_ls = {},
			-- C/C++
			clangd = {},
			-- Json
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
		}

		for name, opts in pairs(server) do
			vim.lsp.config(name, opts)
			vim.lsp.enable(name)
		end
	end,
}
