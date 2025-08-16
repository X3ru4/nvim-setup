return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = "saghen/blink.cmp",
  config = function()
    vim.lsp.config("*", {
      capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("blink.cmp").get_lsp_capabilities())
    })
    local server = {
      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },
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
