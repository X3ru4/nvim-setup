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

  -- nvimdev/lspsaga.nvim
  {
    "nvimdev/lspsaga.nvim",
    opts = {
      ui = {
        border = "rounded",
        devicon = true,
        code_action = " ",
        actionfix = " ",
      },
      symbol_in_winbar = {
        enable = true,
        separator = "  ",
        hide_keyword = false,
        ignore_patterns = nil,
        show_file = true,
        folder_level = 1,
        color_mode = true,
        delay = 20,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
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
