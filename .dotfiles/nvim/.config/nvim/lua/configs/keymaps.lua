-- s.nvim

-- keymaps -------------------------------------------------------------------80

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- quits
vim.keymap.set({"n", "i"}, "<C-q>", ":q!<CR>")
vim.keymap.set({"n", "i"}, "<C-c>", ":close!<CR>")

-- move selection up and down
vim.keymap.set({"n", "i"}, "<A-j>", ":m+<CR>")
vim.keymap.set({"n", "i"}, "<A-k>", ":m-2<CR>")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- window nav
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-w>", "<C-w>w")
vim.keymap.set("n", "<A-=>", "<C-W>=")
vim.keymap.set("n", "<A-_>", "<C-W>_")
vim.keymap.set("n", "<A-|>", "<C-W>|")

-- buffer nav
vim.keymap.set("n", "<A-h>", ":bprevious<CR>")
vim.keymap.set("n", "<A-l>", ":bnext<CR>")

-- terminal
vim.keymap.set("n", "<C-t>", ":term<CR>:set nonumber<CR>")
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>")

-- plugins

-- toggles
vim.keymap.set("n", "<leader>sw", ":StripWhitespace<CR>")
vim.keymap.set("n", "<leader>d",  ":Dashboard<CR>:DisableWhitespace<CR>")
vim.keymap.set("n", "<leader>o",  ":OutlineToggle<CR>")
vim.keymap.set("n", "<leader>f",  ":Oil<CR>")
vim.keymap.set("n", "<leader>u",  ":UndotreeToggle<CR>")

-- fuzzy finding keymaps
local tele_builtin = require("telescope.builtin")
vim.keymap.set({"v", "n"}, "<leader>fs", function() tele_builtin.grep_string({cwd = "~"}) end, {})
vim.keymap.set("n", "<leader>fa", tele_builtin.find_files, {})
vim.keymap.set("n", "<leader>ff", tele_builtin.git_files, {})
vim.keymap.set("n", "<leader>fg", tele_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", tele_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", tele_builtin.help_tags, {})

