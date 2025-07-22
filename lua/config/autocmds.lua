-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- AutoCmd
local autocmd = vim.api.nvim_create_autocmd

-- Show diagnostic on CursorHold
-- autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focusable = false })
--   end,
-- })
