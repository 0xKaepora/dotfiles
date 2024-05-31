-- ~/.config/nvim/lua/config/options.lua
local opt = vim.opt

opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Incremental search
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters
