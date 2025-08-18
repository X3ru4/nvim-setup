return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" },
  config = function ()
    require("fzf-lua").setup()
  end,
  keys = {
    { "<leader>ff", function ()
      require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
    end, desc = "Find file" },
    { "<leader>fc", function ()
      require("fzf-lua").files()
    end, desc = "Find file CWD" }
  }
}
