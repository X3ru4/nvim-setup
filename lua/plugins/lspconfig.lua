return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local server = {
      -- Lua
      lua_ls = {
        capabilities = capabilities,
      },
      -- Html
      html = {
        capabilities = capabilities,
      },
      -- Css
      cssls = {
        capabilities = capabilities,
      },
      -- TypeScript/JavaScript
      tsserver = {
        capabilities = capabilities,
      },
      -- Emmet html
      emmet_language_server = { capabilities = capabilities },
      -- C++
      clangd = {
        capabilities = capabilities,
      },
    }

    for name, opts in pairs(server) do
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
