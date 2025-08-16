return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open oil" },
    { "<leader>E", "<cmd>Oil .<cr>", desc = "Open oil home" }
  }
}
