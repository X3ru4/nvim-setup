return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  config = function ()
    require("fzf-lua").setup({
      winopts = {
        preview = {
          hidden = "hidden",
        }
      }
    })
  end,
  keys = {
    { "<leader>ff", function ()
      require("fzf-lua").files()
    end, desc = "Find file CWD" },
    { "<leader>fF", function ()
      require("fzf-lua").files({ cwd = vim.fn.expand("%:h:p" )})
    end, desc = "Find file" },
    { "<leader>fc", function ()
      require("fzf-lua").files({ cwd = "~/.config/nvim" })
    end, desc = "Find config files" },
    { "<leader>fb", function ()
      require("fzf-lua").buffers()
    end, desc = "Find buffers"},
    { "<leader>fh", function ()
      require("fzf-lua").highlights()
    end, desc = "Find highlights"},
    { "<leader>fd", function ()
      require("fzf-lua").diagnostics_document()
    end, desc = "Find diagnostics"}
  }
}
