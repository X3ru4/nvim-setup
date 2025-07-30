return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local function on_attach(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    end
    local root_dir = require("lspconfig.util").root_pattern(".git", "package.json", ".")
    local enabled = vim.lsp.enable
    local config = vim.lsp.config

    enabled("lua_ls")
    enabled("html")
    enabled("cssls")
    enabled("tsserver")

    config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach(),
    })
    config("html", {
      capabilities = capabilities,
      on_attach = on_attach(),
      cmd = { "html-languageserver", "--stdio" },
    })
    config("cssls", {
      capabilities = capabilities,
      on_attach = on_attach(),
    })
    config("tsserver", {
      capabilities = capabilities,
      on_attach = on_attach(),
    })
  end,
}
