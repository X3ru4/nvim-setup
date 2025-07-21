return {

  -- use colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin"
    }
  },

  -- add cyberdream
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require("cyberdream").setup {
        cache = true,
        transparent = true
      }
    end
  },

  -- add capuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function ()
      require("catppuccin").setup({
        flavour = "auto",
        background = {
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true,
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
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
    end
  }
}


