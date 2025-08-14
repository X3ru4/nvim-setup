return {
  -- which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = {
        border = vim.g.border,
        wo = {
          winblend = vim.g.blend,
        },
      },
    },
  },

  {
    "smjonas/inc-rename.nvim",
    opts = {},
    keys = {
      { "grn", ":IncRename ", desc = "Rename" },
    },
  },

  -- lsp_signature.nvim
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      hint_prefix = " ",
      floating_window = false,
      handler_opts = {
        border = vim.g.border,
      },
    },
  },

  -- nvim-ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
  },

  -- nvim-colorizer.lua
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },

  {
    "echasnovski/mini.align",
    version = "*",
    opts = {},
  },
}
