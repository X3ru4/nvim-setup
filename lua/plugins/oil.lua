return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    {
      "benomahony/oil-git.nvim",
      config = function ()
        require("config.options")
        require("oil-git").setup({
          highlights = {
            OilGitAdded     = { fg = vim.g.color_palette.green  },
            OilGitModified  = { fg = vim.g.color_palette.orange },
            OilGitDeleted   = { fg = vim.g.color_palette.red    },
            OilGitRenamed   = { fg = vim.g.color_palette.purple },
            OilGitUntracked = { fg = vim.g.color_palette.blue   },
            OilGitIgnored   = { fg = vim.g.color_palette.bg3    },
          }
        })
      end
    },
    {
      "JezerM/oil-lsp-diagnostics.nvim",
      opts = {
      diagnostic_symbols = {
          error = require("config.icons").diagnostic.errr,
          warn = require("config.icons").diagnostic.warn,
          info = require("config.icons").diagnostic.info,
          hint = require("config.icons").diagnostic.hint,
        }
      }
    }
  },
  config = function ()
    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = require("oil").get_current_dir(bufnr)
      if dir then
        return vim.fn.fnamemodify(dir, ":~")
      else
        return vim.api.nvim_buf_get_name(0)
      end
    end

    require("oil").setup({
      win_options = {
        winbar = "%!v:lua.get_oil_winbar()",
      },
      keymaps = {
        ["<C-s>"] = {},
        ["<C-h>"] = nil,
        ["g."] = nil,
        ["-"] = nil,
        ["<leader>ff"] = { function ()
          vim.cmd("FZF " .. require("oil").get_current_dir(0))
        end, mode = "n" },
        ["<bs>"] = { "actions.parent", mode = "n" },
        [".."] = { "actions.toggle_hidden", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["<esc>"] = { "actions.close", mode = "n" }
      },
      columns = {
        -- "permissions",
        "size",
        "icon",
        -- "mtime",
      },
    })
  end,
  keys = {
    { "<leader>e", "<cmd>Oil<cr>",   desc = "Open oil" },
    { "<leader>E", "<cmd>Oil .<cr>", desc = "Open oil home" },
  }
}
