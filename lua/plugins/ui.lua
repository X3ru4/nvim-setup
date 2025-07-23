local icons = require("config.icon")

return {

  -- nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = {
            left = "\\",
            right = "/",
          },
          section_separators = {
            left = "",
            right = "",
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            {
              "filetype",
              icon_only = true,
            },
            {
              "filename",
              symbols = {
                modified = icons.icons.modified,
                readonly = "",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostic_icons.errr .. " ",
                warn = icons.diagnostic_icons.warn .. " ",
                info = icons.diagnostic_icons.info .. " ",
                hint = icons.diagnostic_icons.hint .. " ",
              },
            },
            { "searchcount" },
            { "selectioncount" },
            {
              function()
                return " "
              end,
            },
          },
          lualine_z = {
            {
              function()
                return "󰥔 " .. os.date("%R")
              end,
            },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        extensions = {},
      })
    end,
  },

  -- akinsho/bufferline.nvim
  { enabled = false, "akinsho/bufferline.nvim" },

  {
    -- enabled = false,
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      icons = {
        button = icons.icons.close,
        modified = { button = icons.icons.modified },
        pinned = { button = icons.icons.pinned, filename = false },
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = icons.diagnostic_icons.errr .. " " },
          [vim.diagnostic.severity.INFO] = { enabled = false, icon = icons.diagnostic_icons.info .. " " },
          [vim.diagnostic.severity.WARN] = { enabled = false, icon = icons.diagnostic_icons.warn .. " " },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = icons.diagnostic_icons.hint .. " " },
        },
        preset = "default",
        inactive = { button = "" },
      },
      auto_hide = true,
    },
    version = "^1.0.0",
  },

  -- kevinhwang91/nvim-ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = function(capabilities)
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }
        return capabilities
      end,
    },
  },

  -- ray-x/lsp_signature.nvim
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      hint_prefix = " ",
      floating_window = false,
      handler_opts = {
        border = icons.square,
      },
    },
  },

  -- folke/noice.nvim
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.signature = {
        enabled = false,
      }
    end,
  },

  -- nvimdev/dashboard-nvim
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
         ░    ░  ░    ░ ░        ░   ░         ░   
                                ░                  
      ]]
      logo = string.rep("\n", 4) .. logo .. "\n"
      opts.config.header = vim.split(logo, "\n")
      opts.config.center = {
        {
          action = "ene | startinsert",
          desc = " New File",
          icon = " ",
          key = "n",
        },
        {
          action = 'lua LazyVim.pick("projects")()',
          desc = " Recent Files",
          icon = " ",
          key = "p",
        },
        {
          action = "edit ~/.config/nvim",
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = function()
            vim.api.nvim_input("<cmd>qa<cr>")
          end,
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
    end,
  },

  -- rachartier/tiny-inline-diagnostic.nvim
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
