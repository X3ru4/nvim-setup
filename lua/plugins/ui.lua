return {

  -- nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          component_separators = {
            left = '\\',
            right = '/'
          },
          section_separators = {
            left = '',
            right = ''
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              'filetype',
              icon_only = true,
            },
            {
              'filename',
              symbols = {
                modified = '󱇨',
                readonly = '',
                unnamed = '[No Name]',
                newfile = '[New]',
              },
            }
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              'diagnostics',
              symbols = {
                error = ' ',
                warn =  ' ',
                info =  ' ',
                hint =  ' '
              },
              update_in_insert = true,
            },
            { 'searchcount' },
            { 'selectioncount' },
            {
              function ()
                return ' '
              end
            }
          },
          lualine_z = {
            {
              function ()
                return '󰥔 ' .. os.date('%R')
              end
            }
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        extensions = {}
      }
    end,
  },

  -- akinsho/bufferline.nvim
  {
    -- enabled = false,
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.default,
          themable = true,
          numbers = "ordinal",
          indicator = {
            icon = "",
            style = "none",
          },
          buffer_close_icon = " 󰅖",
          modified_icon = " 󱇨",
          close_icon = " ",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
              local icon = level:match("error") and " " or ""
              return " " .. icon .. " " .. count
          end,
          -- diagnostics_update_in_insert = true,
          diagnostics_update_on_event = true,
          separator_style = "slant",
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = true,
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      })
    end,
  },

  {
    enabled = false,
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    config = function ()
      require('barbar').setup {
        icons = {
          button = icons.close,
          modified = { button = icons.modified },
          pinned = { button = icons.pinned, filename = false },
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = true,  icon = diagnostic_icons.errr},
            [vim.diagnostic.severity.WARN]  = {enabled = false, icon = diagnostic_icons.warn},
            [vim.diagnostic.severity.INFO]  = {enabled = false, icon = diagnostic_icons.info},
            [vim.diagnostic.severity.HINT]  = {enabled = true,  icon = diagnostic_icons.hint},
          },
          preset = 'default',
          inactive = { button = '' }
        }
      }
    end,
    version = '^1.0.0',
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
        border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
      }
    },
  },

  -- folke/noice.nvim
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.signature = {
        enabled = false
      }
    end,
  },

  -- nvimdev/dashboard-nvim
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function (_, opts)
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
      logo = string.rep('\n', 4) .. logo .. '\n'
      opts.config.header = vim.split(logo, '\n')
      opts.config.center = {
        { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
        { action = 'lua LazyVim.pick("projects")()',                 desc = " Recent Files",    icon = " ", key = "p" },
        { action = 'edit ~/.config/nvim',                            desc = " Config",          icon = " ", key = "c" },
        { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
      }
    end
  },
}

