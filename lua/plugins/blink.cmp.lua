return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = "rafamadriz/friendly-snippets",
  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-y>"] = false,
      ["<CR>"] = { "select_and_accept", "fallback" },
    },
    cmdline = {
      enabled = true,
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
          winhighlight = "Normal:Normal,FloatBorder:myFloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
      menu = {
        min_width = 5,
        max_height = 8,
        winblend = vim.g.blend,
        border = vim.g.border,
        winhighlight = "Normal:Normal,FloatBorder:myFloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
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
                if ctx.item.source_name == "LSP" then
                  local color_item =
                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr ~= "" then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local highlight = "BlinkCmpKind" .. ctx.kind
                if ctx.item.source_name == "LSP" then
                  local color_item =
                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end,
            },
          },
        },
      },
    },
  },
}
