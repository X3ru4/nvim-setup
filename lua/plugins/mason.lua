return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "luacheck",
            "markdown-toc",
            "markdownlint",
            "markdownlint-cli2",
            "marksman",
            -- "html-lsp",
            -- "markuplint",
            -- "css-lsp",
            -- "stylelint",
            -- "prettier",
            -- "emmet-language-server",
          },
        })
        require("mason-tool-installer").run_on_start()
      end,
    },
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "BufReadPre",
    opts = {},
    config = function() end
  }
}
