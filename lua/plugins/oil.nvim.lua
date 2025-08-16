return {
  'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  opts = {
    keymaps = {
      ["<bs>"] = { "actions.parent", mode = "n" },
    }
  },
  keys = {
    { "<leader>e", "<cmd>Oil<cr>",   desc = "Open oil" },
    { "<leader>E", "<cmd>Oil .<cr>", desc = "Open oil home" },
  }
}
