local map = vim.keymap.set

map("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gra", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "grr", vim.lsp.buf.references, { desc = "References" })
map("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition" })

map("!", "<F11>", "<Nop>")

map("t", "<C-b>", "<cmd>e #<cr>")

-- Run code
map("n", "<leader>cr", "<cmd>terminal ./run.sh<cr>")

-- Restart file
map("n", "gof", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("edit " .. file)
  vim.cmd("BufferLineCloseLeft")
end, { desc = "" })

-- Save session and quit auto restore
map("n", "gos", function()
  vim.cmd("w")
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
