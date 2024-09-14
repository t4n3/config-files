-- Visual
vim.o.cmdheight = 1
vim.o.pumheight = 10
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.title = true
vim.o.termguicolors = true
vim.o.foldmethod = 'marker'
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.cursorline = true
vim.opt.colorcolumn = "80"

-- Behavior
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.mouse = "a"
vim.o.clipboard = 'unnamedplus'

-- Vim specific
vim.o.hidden = true
vim.o.spell = false
vim.o.updatetime = 300

--Disable unsused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--Set black highlight color
vim.cmd([[highlight black ctermfg=Black guifg=Black]])
