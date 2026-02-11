vim.lsp.inlay_hint.enable(false)
local keymap = require("config.keymaps")

local servers = {
	-- Lua
	lua_ls = {},

	-- C/C++
	clangd = {},

	-- Python
	basedpyright = {
		settings = {
			basedpyright = {
				disableOrganizeImports = true, -- Using Ruff
				useLibraryCodeForTypes = true,
				typeCheckingMode = "standard",
				diagnosticMode = "openFilesOnly",
			},
			python = {
				analysis = {
					useLibraryCodeForTypes = true,
					ignore = { "*" }, -- Using Ruff
				},
			},
		},
	},
	ruff = {
		on_attach = function(client, bufnr)
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end,
		init_options = {
			settings = {
				-- Any extra CLI arguments for `ruff` go here.
				args = {},
			},
		},
	},
}

local on_attach = function(_, bufnr)
	keymap.lsp(_, bufnr)
end
vim.lsp.config("*", { on_attach = on_attach() })

for name, config in pairs(servers) do
	-- Skip define lsp if config is false
	if config == false then
		goto eol
	end

	vim.lsp.config(name, config)
	vim.lsp.enable(name)
	::eol::
end

local icons = require("config.icons").diagnostic
vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		suffix = "",
		format = function(diagnostic)
      local severity = {
        [vim.diagnostic.severity.ERROR] = string.format("%s : %s", icons.Error, diagnostic.message),
        [vim.diagnostic.severity.WARN] = string.format("%s : %s", icons.Warn, diagnostic.message),
        [vim.diagnostic.severity.INFO] = string.format("%s : %s", icons.Info, diagnostic.message),
        [vim.diagnostic.severity.HINT] = string.format("%s : %s", icons.Hint, diagnostic.message),
      }
			return severity[diagnostic.severity]
		end,
	},
	underline = false,
	float = {
		header = "",
    prefix = ">> ",
		source = "if_many",
		wrap = true,
	},
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.Error,
			[vim.diagnostic.severity.WARN] = icons.Warn,
			[vim.diagnostic.severity.INFO] = icons.Info,
			[vim.diagnostic.severity.HINT] = icons.Hint,
		},
	},
})
