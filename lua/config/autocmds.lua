local autocmd = vim.api.nvim_create_autocmd

autocmd({ "CursorHoldI", "CursorHold" }, {
  callback = function()
    vim.diagnostic.open_float({ focus = false })
  end,
})
