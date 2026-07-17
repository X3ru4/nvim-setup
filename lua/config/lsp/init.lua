local icons = require("config.icons").diagnostic
local severity_icons = {
	[vim.diagnostic.severity.ERROR] = icons.Error,
	[vim.diagnostic.severity.WARN] = icons.Warn,
	[vim.diagnostic.severity.INFO] = icons.Info,
	[vim.diagnostic.severity.HINT] = icons.Hint,
}

vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			return " " .. severity_icons[diagnostic.severity]
		end,
		suffix = " ",
	},
	underline = false,
	float = { source = "if_many" },
	update_in_insert = false,
	signs = {
		text = severity_icons,
	},
})

vim.lsp.inlay_hint.enable(false)

for name, config in require("utility.loader").load_file("lua/config/lsp") do
	if type(config) == "table" then
		vim.lsp.config(name:gsub("%.lua$", ""), config)
	end
end
