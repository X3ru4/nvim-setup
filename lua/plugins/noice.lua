return {
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
}
