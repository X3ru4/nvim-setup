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
          },
        },
      },
    },
  },
}
