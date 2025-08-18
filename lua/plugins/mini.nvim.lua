return {
  { "echasnovski/mini.icons" },
  { 'echasnovski/mini.surround', event = "BufReadPost", version = '*', opts = {} },
  { 'echasnovski/mini.align', event = "BufReadPost", version = '*', opts = {} },
  { 'echasnovski/mini.move', event = "BufReadPost", version = '*', opts = {} },
  {
    'echasnovski/mini.pairs',
    event = "InsertEnter",
    version = '*',
    opts = {
      modes = { insert = true, command = true, terminal = false },
    }
  },
  {
    'echasnovski/mini.ai',
    event = "BufReadPost",
    version = '*',
    opts = function ()
      local ai = require("mini.ai")
      local opts = {
        n_lines = 500,
        custom_textobjects = {
          a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
          i = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          d = { "%f[%d]%d+" },
        },
      }
      return opts
    end
  },
}
