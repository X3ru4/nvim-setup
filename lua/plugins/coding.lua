return {

  -- hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "onsails/lspkind-nvim" },
    opts = function(_, opts)
      local cmp = require("cmp")
      local round  = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      local square = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
      opts.performance = {
        debounce = 0,
        throttle = 0,
      }
      opts.window = {
        completion = cmp.config.window.bordered {
          border = square,
          winhighlight = "Normal:menu,FloatBorder:FloatBorder,CursorLine:menu_sl",
        },
        documentation = cmp.config.window.bordered {
          border = square,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      }
      local lspkind = require('lspkind')
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
          mode = 'symbol',
          maxwidth = {
            menu = 20,
            abbr = 20,
          },
          ellipsis_char = '~',
          show_labelDetails = true,
          before = function (entry, vim_item)
            return vim_item
          end
        }
      }
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- brenton-leighton/multiple-cursors.nvim
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",  -- Use the latest tagged version
    opts = {},  -- This causes the plugin setup function to be called
    keys = {
      {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "x"}, desc = "Add cursor and move down"},
      {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "x"}, desc = "Add cursor and move up"},

      {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move up"},
      {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move down"},

      {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}, desc = "Add or remove cursor"},

      {"<Leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", mode = {"x"}, desc = "Add cursors to the lines of the visual area"},

      {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add cursors to cword"},
      {"<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n", "x"}, desc = "Add cursors to cword in previous area"},

      {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Add cursor and jump to next cword"},
      {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to next cword"},

      {"<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = {"n", "x"}, desc = "Lock virtual cursors"},
    },
  },

}
