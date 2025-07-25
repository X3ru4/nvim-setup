return {

  -- neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      -- C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      -- ...
    end,
  },

  -- williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "clang-format",
        "cpplint",
        "luacheck",
        "markdown-toc",
        "markdownlint",
        "markdownlint-cli2",
        "marksman",
        "shellcheck",
        "shellharden",
        "shfmt",
        "sonarlint-language-server",
        "trivy",
      },
    },
  },
}
