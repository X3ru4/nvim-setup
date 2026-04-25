return {
  {
    "rachartier/tiny-cmdline.nvim",
    enabled = false,
    event = "UiEnter",
    priority = 1000,
    config = function()
      vim.o.cmdheight = 0
      require("tiny-cmdline").setup({
        on_reposition = require("tiny-cmdline").adapters.blink,
        border = "rounded",
        native_types = { "r", "?" },
      })
    end,
  },
}
