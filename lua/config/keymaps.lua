local map = vim.keymap.set

map("!", "<F11>", "<Nop>")

-- Restart file
map("n", "gof", function()
  local file = vim.fn.expand("%:p")
  Snacks.bufdelete()
  vim.cmd("edit " .. file)
end, { desc = "" })

-- Save session and quit auto restore
map("n", "gos", function()
  vim.fn.writefile({ "Hello" }, vim.fn.stdpath("data") .. "/restore.flag")
  vim.cmd("qa")
end, { desc = "Quit auto restore" })

map("n", "goo", function()
  vim.notify("Source " .. vim.fn.fnamemodify(vim.env.MYVIMRC, ":t"))
  vim.cmd("so $MYVIMRC")
end, { desc = "Source init.lua" })
map("n", "gog", function()
  vim.notify("Source " .. vim.fn.expand("%:t"))
  vim.cmd("so %")
end, { desc = "Source current" })

-- Terminal
map("n", "gb", "<cmd>terminal<cr>i", { desc = "Terminal" })

-- Quick matching
map("i", "<C-a>", "<Esc>%i")

-- Yank all to clipboard
map("n", "<leader>ya", "<cmd>%y+<cr>", { desc = "Yank all to clipboard" })

-- Select all
map("n", "<leader>v", "gg0vG$", {
  desc = "Select all",
})

-- Select all line
map("n", "<leader>V", "ggVG$", {
  desc = "Select all line",
})

map({ "n" }, "<C-k>", function()
  require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

map({ "n" }, "<Leader>k", function()
  vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "toggle signature" })

map("n", "<leader>nr", ":IncRename<leader>", {
  desc = "IncRename",
})
