return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local lsp = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local function on_attach(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    end
    -- Lua
    lsp.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach(),
    })
    -- HTML
    lsp.html.setup({
      capabilities = capabilities,
      on_attach = on_attach(),
      settings = {
        html = {
          format = {
            enable = true,
          },
        },
        embeddedLanguages = {
          css = true,
          javascript = true,
        },
      },
    })
    -- CSS
    lsp.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach(),
    })
    -- TypeScript & JavaScript
    lsp.tsserver.setup({
      capabilities = capabilities,
      on_attach = on_attach(),
    })
  end,
}
