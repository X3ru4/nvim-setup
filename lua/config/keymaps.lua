-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

keymap("!", "<F11>", "<Nop>")

-- Terminal
keymap("n", "gb", "<cmd>terminal<CR>i", { desc = "Terminal" })

-- Quick matching
keymap("i", "<C-a>", "<Esc>%i")

-- Yank all to clipboard
keymap("n", "<leader>ya", "<cmd>%y+<CR>", { desc = "Yank all to clipboard" })

-- Select all
keymap("n", "<leader>v", "gg0vG$", {
  desc = "Select all"
})

-- Select all line
keymap("n", "<leader>V", "ggVG$", {
  desc = "Select all line"
})

keymap({ 'n' }, '<C-k>', function()       require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, desc = 'toggle signature' })


keymap({ 'n' }, '<Leader>k', function()
  vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })

keymap('n', '<leader>nr', ':IncRename<leader>', {
  desc = 'IncRename'
})

keymap("n", "<C-<CR>>", "<cmd>call append(line('.') -1, '')<CR>", { desc="Append line up"})
keymap("n", "<C-<BS>>", "<cmd>call append(line('.'), '')<CR>", { desc="Append line down"})
