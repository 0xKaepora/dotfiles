-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set

-- Better up/down movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Save file
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
