return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    { "rafamadriz/friendly-snippets", },
    { "onsails/lspkind.nvim" }
  },
  version = "1.*",
  opts = {
    keymap = {
      preset = "enter",
    },
    cmdline = {
      enabled = true,
      keymap = {
        preset = "default",
      },
      completion = { menu = { auto_show = true } },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = { enabled = false },
    completion = {
      documentation = {
        auto_show = true,
        window = {
          min_width = 5,
          max_width = 30,
          max_height = 10,
          winblend = vim.g.blend,
          border = vim.g.border,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
      menu = {
        min_width = 5,
        max_height = 8,
        winblend = vim.g.blend,
        border = vim.g.border,
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        draw = {
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "kind" },
          },
          components = {
            label = {
              width = { fill = true, max = 30 },
            },
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                        icon = dev_icon
                    end
                else
                    icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                    })
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            }
          },
          treesitter = { "lsp" }
        },
      },
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
