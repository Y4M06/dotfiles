
vim.opt.nu = true

-- UI
vim.opt.guicursor =  "a:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.colorcolumn = "81"
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Indentation
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.listchars = {
  tab = "| ",
  trail = "-",
}

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"





















