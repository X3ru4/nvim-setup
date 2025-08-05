return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "luacheck",
      "markdown-toc",
      "markdownlint",
      "markdownlint-cli2",
      "marksman",
      "html-lsp",
      "markuplint",
      "css-lsp",
      "stylelint",
      "prettier",
      "emmet-language-server",
    },
    ui = { border = vim.g.border },
  },
}
