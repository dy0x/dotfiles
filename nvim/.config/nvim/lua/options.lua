-- Display
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣,lead:·'

-- Indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.breakindent = true

-- Search and substitution
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Editing and interaction
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.confirm = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
