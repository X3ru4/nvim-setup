return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup({
      preset = "simple",
      options = {
        multilines = { enabled = true, },
        use_icons_from_diagnostic = true,
        set_arrow_to_diag_color = false,
        add_messages = true,
        show_all_diags_on_cursorline = false,
        enable_on_insert = vim.g.on_insert,
        enable_on_select = false,
      },
    })
  end
}
