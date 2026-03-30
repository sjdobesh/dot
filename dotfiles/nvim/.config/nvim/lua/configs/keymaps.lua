-- # s.nvim keymaps
------------------------------------------------------------------------------80

-- helper function
-- useful for conditional mappings and hacks
local function feedkeys(keys, mode, escape_ks)
  local replaced_keys = vim.api.nvim_replace_termcodes(keys, true, true, escape_ks)
  vim.api.nvim_feedkeys(replaced_keys, mode, escape_ks)
end

-----
-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-----
-- quit / refresh
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>q!<CR>", { desc = "close program" })
vim.keymap.set({ "n", "i" }, "<C-c>", "<cmd>close!<CR>", { desc = "close window" })
vim.keymap.set({ "n", "i" }, "<C-b>", "<cmd>bd!<CR>", { desc = "close buffer" })
vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>", { desc = "clear highlights" })
vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>", { desc = "restart neovim" })

-----
-- move selection
vim.keymap.set({ "n", "i" }, "<A-j>", "<cmd>m+<CR>", { desc = "move line down" })
vim.keymap.set({ "n", "i" }, "<A-k>", "<cmd>m-2<CR>", { desc = "move line up" })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("n", "<A-h>", "Xph", { desc = "move character left" })
vim.keymap.set("n", "<A-l>", "xp", { desc = "move character right" })
vim.keymap.set("v", "<A-h>", "xhPgv=gv", { desc = "rotate selection left" })
vim.keymap.set("v", "<A-l>", "xpgv=gv", { desc = "rotate selection right" })

-----
-- append/prepend visual
vim.keymap.set("x", "<C-a>", function()
  local arg = vim.fn.input("append: ")
  feedkeys(": '<,'>normal A" .. arg .. "<CR>", "v", true)
end, { desc = "append to selection" })
vim.keymap.set("x", "<C-i>", function()
  local arg = vim.fn.input("prepend: ")
  feedkeys(": '<,'>normal I" .. arg .. "<CR>", "v", true)
end, { desc = "prepend to selection" })

-----
-- window nav
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "move window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "move window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "move window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "move window right" })
vim.keymap.set("n", "<C-w>", "<C-w>w", { desc = "toggle windows" })

-----
-- buffer nav
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "tab left" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "tab right" })

-----
-- terminal nav
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "escape terminal capture" })
vim.keymap.set("n", "<leader>cd", function()
  vim.cmd("cd %:p:h")
end, { desc = "cd to current file" })

-----
-- compilation
vim.keymap.set("n", "<leader><", ":Compile<cr>", { desc = "compile buffer" })
vim.keymap.set("n", "<leader>>", ":Recompile<cr>", { desc = "rerun compile buffer" })
vim.keymap.set("n", "<leader>!", ":make<cr>", { desc = "filetype make" })

local function bangbuf(cmd)
  -- write objdump to new file
  vim.cmd("vsp")
  local target_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(target_buf)
  vim.cmd("read !" .. cmd)
end

vim.keymap.set("n", "<leader>so", function()
  local cmd = vim.fn.input(":buf!")
  if cmd == "" then
    return
  else
    bangbuf(cmd)
  end
end, { desc = "dump shell output to new buffer" })

-- write hex to new file
vim.keymap.set("n", "<leader>x", function()
  local source_buf = vim.api.nvim_get_current_buf()
  local data = vim.api.nvim_buf_get_lines(source_buf, 0, -1, false)
  local target_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, data)
  vim.api.nvim_set_current_buf(target_buf)
  feedkeys(":%!xxd<cr>", "n", true)
  vim.g.hexmode = true
end, { desc = "dump current file hex to new buffer" })

-- toggle current file
vim.g.hexmode = false
vim.keymap.set("n", "<leader>X", function()
  if vim.g.hexmode == false then
    feedkeys(":%!xxd<cr>", "n", true)
  else
    feedkeys(":%!xxd -r<cr>", "n", true)
  end
  vim.g.hexmode = not vim.g.hexmode
end, { desc = "toggle hex view" })

-----
-- lsp
-- stylua: ignore start
vim.keymap.set("n", "gb", "<C-O>", { desc = "go back" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "get definition" })
vim.keymap.set("n", "gi", function() vim.lsp.buf.hover() end, { desc = "get information" })
vim.keymap.set("n", "ge", function() vim.diagnostic.open_float({ scope = "line" }) end, { desc = "get error" })
vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end, { desc = "get references" })
-- stylua: ignore end

-----
-- hacks

-- make a new file path from WORD under cursor
local function makeNewFile()
  local word = vim.fn.expand("<cWORD>")
  local newpath = word:match("[.~]*/[%w/]+")
  local choice = vim.fn.confirm(newpath, "create file? &yes\n&no")
  if choice == 1 then
    feedkeys(":e " .. newpath .. "<cr>", "n", true)
  end
end
vim.keymap.set("n", "gnf", function()
  makeNewFile()
end, { desc = "get new file under cursor" })

-- macro wrapper
vim.keymap.set("n", "<leader>m", function()
  local register = vim.fn.getchar(-1, { number = false })
  for _ = 1, vim.v.count1 do
    vim.cmd("normal! @" .. register)
  end
end, { desc = "run macro" })

-- the perfect comment seperator
vim.keymap.set("n", "<leader>8", function()
  local ft = vim.bo.filetype
  print(ft)
  if ft == "bash" then
    feedkeys("i#-------------------------------------------------------------------------------<ESC>", "n", true)
  elseif ft == "lua" then
    feedkeys("i--------------------------------------------------------------------------------<ESC>", "n", true)
  elseif ft == "c" then
    feedkeys("i/*----------------------------------------------------------------------------*/<ESC>", "n", true)
  else
    feedkeys("i--------------------------------------------------------------------------------<ESC>", "n", true)
  end
end)

-----
-- ## plugins

-- command maps
vim.keymap.set("n", "<leader>d", "<cmd>Dashboard<CR><cmd>DisableWhitespace<CR>", { desc = "open dashboard" })
vim.keymap.set("n", "<leader>w", "<cmd>StripWhitespace<CR>", { desc = "strip whitespace" })

-- toggles
vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "toggle symbol viewer" })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "toggle undotree" })
vim.keymap.set("n", "<leader>l", "<cmd>UrlView<CR>", { desc = "toggle link viewer" })
-- persistent autosession toggle
vim.g.neotreeopen = false
vim.keymap.set("n", "<leader>f", function()
  vim.g.neotreeopen = not vim.g.neotreeopen
  vim.cmd("Neotree toggle")
end, { desc = "toggle neotree and record state for autosession" })

-----
-- leap (s)kip to (2 letter search)
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "2 letter search forwards" })
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "2 letter search backwards" })

-----
-- notify clear
vim.keymap.set("n", "<Esc>", ':lua require("notify").dismiss()<CR>', { desc = "dismiss fancy notifications" })

-----
-- nvim-treesitter-textobjects

-- select
-- function blocks
vim.keymap.set({ "x", "o" }, "am", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "select around function" })
vim.keymap.set({ "x", "o" }, "im", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "select inside function" })
-- class blocks
vim.keymap.set({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "select around class" })
vim.keymap.set({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "select inside class" })

-- swap arguments
vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end, { desc = "swap next arg" })
vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
end, { desc = "swap prev arg" })

-- move
-- functions next / previous
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "goto next function" })
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "goto previous function" })
vim.keymap.set({ "n", "x", "o" }, "]M", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "goto next function end" })
vim.keymap.set({ "n", "x", "o" }, "[M", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "goto previous function end" })

-- class next / previous
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "goto next class" })
vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "goto previous class" })
vim.keymap.set({ "n", "x", "o" }, "][", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end, { desc = "goto next class end" })
vim.keymap.set({ "n", "x", "o" }, "[]", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end, { desc = "goto previous class end" })

-- next loop
vim.keymap.set({ "n", "x", "o" }, "]o", function()
  require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end, { desc = "goto next loop start" })
-- next scope
vim.keymap.set({ "n", "x", "o" }, "]s", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end, { desc = "goto next scope" })
-- next fold
vim.keymap.set({ "n", "x", "o" }, "]z", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end, { desc = "goto next fold" })

-- next / previous condition
vim.keymap.set({ "n", "x", "o" }, "]?", function()
  require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end, { desc = "goto next conditional" })
vim.keymap.set({ "n", "x", "o" }, "[?", function()
  require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end, { desc = "goto previous conditional" })

-- externally defined keymaps

--[[
[linkview](./lua/plugins/linkview.lua)
| keys | command |
| -- | -- |
| gl | get link |
|gL | get previous link |
]]

--[[
[neotree](./lua/plugins/neotree.lua)
| keys | command |
| -- | -- |
| P | preview file |

]]
