vim.g.mapleader = " "

local keymap = vim.keymap

-- page up/down with recentering
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Move around windows (shifted to the right)
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Window resizing
keymap.set("n", "<Left>", "5<C-w><")
keymap.set("n", "<Right>", "5<C-w>>")
keymap.set("n", "<Up>", "5<C-w>+")
keymap.set("n", "<Down>", "5<C-w>-")

-- Move on indent mode
keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-l>", "<Right>")

-- Splits
keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical split" })
keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal split" })

keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- Copy/Paste System Clipboard
keymap.set({ "n", "v" }, "<C-y>", '"+y')
keymap.set({ "n", "v" }, "<C-p>", '"+p')


