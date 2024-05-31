-- ~/.config/nvim/lua/config/autocmds.lua
local autocmd = vim.api.nvim_create_autocmd

-- Automatically reload the file when it is changed outside of Neovim
autocmd("BufEnter", {
  pattern = "*",
  command = "checktime",
})

-- Highlight on yank
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
