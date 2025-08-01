return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
      view = "cmdline",
    },
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    popupmenu = {
      enabled = false,
    },
    notify = { enabled = true, view = "mini" },
    lsp = {
      signature = { enabled = false },
      hover = { enabled = false },
    },
  },
}
