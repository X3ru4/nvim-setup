return {

  -- use colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = _G.colorscheme,
    },
  },

  -- add cyberdream
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        cache = true,
        transparent = _G.transparent,
      })
    end,
  },

  -- add catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto",
        background = {
          light = "latte",
          dark = "frappe",
        },
        transparent_background = _G.transparent,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        default_integrations = true,
        integrations = {
          notify = true,
        },
      })
    end,
  },

  -- add tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      cache = true,
      style = "night",
      transparent = _G.transparent,
    },
  },
}
