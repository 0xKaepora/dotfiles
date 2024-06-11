-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- function to delete buffer
local function delete_buffer()
	local bufnr = vim.fn.bufnr("%") -- Get the buffer number of the current buffer
	vim.api.nvim_command("bp") -- Close the current buffer
	vim.api.nvim_command("bw " .. bufnr) -- Wipe out the buffer
end
map("n", "<leader>bd", delete_buffer, { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>bd<cr>", { desc = "Delete Buffer and Window" })

-- return to explorer
map("n", "<leader>pv", vim.cmd.Ex)

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Saner behavior of n and N
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Keep paste register after replacing
map("x", "<leader>p", [["_dP]])

-- save file
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- keywordprg
-- map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
local function format_buffer()
	vim.lsp.buf.format({ async = true })
end
map("n", "<leader>cf", format_buffer, { desc = "Format" })
map("v", "<leader>cf", format_buffer, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
map("n", "<leader>uf", function()
	vim.lsp.buf.formatting_sync(nil, 1000)
end, { desc = "Toggle Auto Format (Global)" })
map("n", "<leader>us", function()
	vim.o.spell = not vim.o.spell
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
	vim.o.wrap = not vim.o.wrap
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uL", function()
	vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function()
	vim.o.number = not vim.o.number
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function()
	vim.diagnostic.disable()
end, { desc = "Disable Diagnostics" })
map("n", "<leader>uD", function()
	vim.diagnostic.enable()
end, { desc = "Enable Diagnostics" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
	vim.o.conceallevel = vim.o.conceallevel == 0 and conceallevel or 0
end, { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
	map("n", "<leader>uh", function()
		vim.lsp.inlay_hint(0, nil)
	end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>uT", function()
	if vim.b.ts_highlight then
		vim.treesitter.stop()
	else
		vim.treesitter.start()
	end
end, { desc = "Toggle Treesitter Highlight" })
map("n", "<leader>ub", function()
	vim.o.background = vim.o.background == "light" and "dark" or "light"
end, { desc = "Toggle Background" })

-- lazygit
map("n", "<leader>gg", "<cmd>!lazygit<cr>", { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", "<cmd>!lazygit<cr>", { desc = "Lazygit (cwd)" })
map("n", "<leader>gb", "<cmd>!lazygit blame<cr>", { desc = "Git Blame Line" })

map("n", "<leader>gf", function()
	local git_path = vim.api.nvim_buf_get_name(0)
	vim.fn.jobstart("lazygit -f " .. vim.trim(git_path), { detach = true })
end, { desc = "Lazygit Current File History" })

map("n", "<leader>gl", "<cmd>!lazygit log<cr>", { desc = "Lazygit Log" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- floating terminal
map("n", "<leader>ft", "<cmd>lua require('toggleterm').toggle()<cr>", { desc = "Terminal (Root Dir)" })
map("n", "<leader>fT", "<cmd>lua require('toggleterm').toggle()<cr>", { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (Root Dir)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Uncomment these lines if the 'LazyVim' plugin is installed
-- map("n", "<leader>wm", function() LazyVim.toggle.maximize() end, { desc = "Maximize Toggle" })
-- map("n", "<leader>m", function() LazyVim.toggle.maximize() end, { desc = "Maximize Toggle" })
