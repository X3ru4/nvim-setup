return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local function on_attach(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    end

    local server = {
      -- Lua
      lua_ls = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
      -- Html
      html = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
      -- Css
      cssls = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
      -- TypeScript/JavaScript
      tsserver = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
      -- Emmet html
      emmet_language_server = { capabilities = capabilities },
      -- C++
      clangd = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
    }

    for name, opts in pairs(server) do
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
