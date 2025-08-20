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
}
