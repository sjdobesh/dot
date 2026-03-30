-- s.nvim

-- options -------------------------------------------------------------------80

-- load filetype files after other init
vim.cmd("filetype plugin on")

-- core
vim.opt.number = true -- line numbering
vim.opt.relativenumber = true -- relative line numbering
vim.opt.wrap = false -- no wrap
vim.opt.signcolumn = "number" -- lets signs and numbers share a collumn
vim.opt.mouse = "a" -- mouse support
vim.opt.spelllang = "en-gb" -- default dictionary
vim.opt.path:append("**") -- better file nav
vim.o.scrolloff = 4 -- absolute lines

-- tabs (2 tab width as spaces is default)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true

-- smart searching
vim.opt.ignorecase = true -- ignore case in searches
vim.opt.smartcase = true -- unless its a capital
vim.opt.gdefault = true

-- folding
vim.opt.foldmethod = "syntax"
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 7

-- terminal
vim.opt.shell = "fish"
vim.opt.termguicolors = true

-- title
vim.opt.title = true
vim.opt.titlestring = "%<%F%=%l/%L - nvim"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- open new split panes to right and below (as expected)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- set plugin notifications
-- error diagnostic is fine as notify is in fact a function
vim.notify = vim.schedule_wrap(require("notify"))
