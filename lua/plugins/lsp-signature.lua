return {
  enabled = false,
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    hint_prefix = "🧠 ",
    floating_window = false,
    handler_opts = {
      border = vim.g.border,
    },
  }
}
