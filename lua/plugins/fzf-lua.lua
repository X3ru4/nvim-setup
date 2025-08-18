return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  config = function ()
    require("fzf-lua").setup()
  end,
  keys = {
    { "<leader>ff", function ()
      vim.api.nvim_command("FZF " .. vim.fn.expand("%:h:p"))
    end, desc = "Find file" },
    { "<leader>fc", "<cmd>FZF<cr>", desc = "Find file CWD" }
  }
}
