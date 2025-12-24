vim.lsp.inlay_hint.enable(false)

local servers = {
	-- Lua
	lua_ls = {},
	-- C/C++
	clangd = {},
	-- Python
	basedpyright = {},
	pyright = {},
}

for name, config in pairs(servers) do
	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

local icons = require("config.icons").diagnostic
vim.diagnostic.config({
	virtual_text = {
		prefix = "",
	},
	underline = false,
	float = { border = nil, header = "", source = "if_many" },
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.errr,
			[vim.diagnostic.severity.WARN] = icons.warn,
			[vim.diagnostic.severity.INFO] = icons.info,
			[vim.diagnostic.severity.HINT] = icons.hint,
		},
	},
})
