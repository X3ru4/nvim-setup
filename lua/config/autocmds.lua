local cmd = vim.api.nvim_create_autocmd

cmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})
