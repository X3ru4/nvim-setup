local icons = require("config.icon")

return {

  -- nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        component_separators = {
          left = "\\",
          right = "/",
        },
        section_separators = {
          left = "",
          right = "",
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "" },
          },
        },
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
            separator = { right = "" },
          },
        },
      },
    },
  },

  -- akinsho/bufferline.nvim
  {
    -- enabled = false,
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        buffer_close_icon = icons.icons.close .. " ",
        modified_icon = icons.icons.modified .. " ",
        close_icon = " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",
        diagnostics = "nvim_lsp",
        hover = { enabled = false },
      },
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
        border = _G.border,
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
      logo = string.rep("\n", 8) .. logo .. "\n"
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
      opts.config.footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return { "󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
      end
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
