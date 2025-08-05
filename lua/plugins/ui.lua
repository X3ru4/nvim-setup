local icons = require("config.icons").icons
local errorfg = vim.api.nvim_get_hl(0, { name = "ErrorMsg", link = false }).fg
local diagnostic = require("config.icons").diagnostic

return {

  -- lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
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
              modified = require("config.icons").icons.modified,
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
            update_in_insert = vim.g.update_in_insert,
            symbols = {
              error = diagnostic.errr .. " ",
              warn = diagnostic.warn .. " ",
              info = diagnostic.info .. " ",
              hint = diagnostic.hint .. " ",
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

  -- bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        buffer_close_icon = icons.close .. " ",
        modified_icon = icons.modified .. " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",
        diagnostics = "nvim_lsp",
        hover = { enabled = false },
        -- show_buffer_close_icons = false,
        indicator = { style = "none" },
        separator_style = "thin",
      },
      highlights = {
        tab_close = {
          fg = errorfg,
        },
        close_button = {
          fg = errorfg,
        },
        close_button_visible = {
          fg = errorfg,
        },
        close_button_selected = {
          fg = errorfg,
          bold = true,
        },
      },
    },
  },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = { view = "cmdline" },
      messages = {
        enabled = true,
        view = "mini",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      popupmenu = { enabled = false },
      notify = { enabled = false },
      lsp = {
        signature = { enabled = false },
        hover = { enabled = false },
      },
    },
  },

  -- mini.indentscope
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      draw = {
        delay = 0,
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = { dashboard = { enabled = false } },
  },
  -- dashboard-nvim
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
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
      ]]
      logo = string.rep("\n", 6) .. logo .. "\n"
      require("dashboard").setup({
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            {
              action = "ene | startinsert",
              desc = " New File",
              icon = " ",
              key = "n",
            },
            {
              action = 'lua LazyVim.pick("projects")()',
              desc = " Projects",
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
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      })
    end,
  },
}
