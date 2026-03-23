-- # s.nvim keymaps
------------------------------------------------------------------------------80
--[[

## core keymaps
these are all the keymaps defined in this file

| type | key | map |
| -- | -- | -- |
| leader | " " | leader |
| | "\\" | local leader |
| exiting | "<C-q>" | close  |
| | "<C-c>" | close window |
| | "<C-b>"| close buffer |
| refreshing |  "<leader>/"| unhighlight search |
| |  "<leader>r"| restart system |
| selection |  "<A-j>" / "<A-k>" | move line/selection   |
| navigation |  "<C-h>" / "<C-j>" / "<C-k>" / "<C-l>" | window movement |
| | "<A-h>" / "<A-l>"| tab navigation |
| window sizing |  "<C-w>w"| "<C-w>w"|
| |  "<A-=>"| "<C-W>="|
| |  "<A-_>"| "<C-W>_"|
| |  "<A-\|>" | "<C-W>\|" |
| terminal |"<C-q>"| escape terminal input |
| |"<leader>cd"| cd to current buffer |
| compilation | "<leader>?"| compile buffer |
| | "<leader>>"| filetype specific make |
| lsp navigation | "gd" | go to definition |
| | "gb" | go back          |
| | "ge" | get error        |
| | "gi" | get info         |
| | "gr" | get references   |
| | "gx" | get url |
| | "gf" | get file |
| | "]d" | next diagnostic |
| | "[d" | previous diagnostic |
| | "]u" | next link |
| | "[u" | previous link |
| | "K" | documentation |
| hacks | "<leader>m" | execute macros |
| |  "<leader>8" | draws 80 char bar |

]]
-----
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
vim.keymap.set({ "n", "i" }, "<C-q>", "<cmd>q!<CR>")
vim.keymap.set({ "n", "i" }, "<C-c>", "<cmd>close!<CR>")
vim.keymap.set({ "n", "i" }, "<C-b>", "<cmd>bd!<CR>")
vim.keymap.set("n", "<leader>/", "<cmd>noh<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>restart<CR>")

-----
-- move selection
vim.keymap.set({ "n", "i" }, "<A-j>", "<cmd>m+<CR>")
vim.keymap.set({ "n", "i" }, "<A-k>", "<cmd>m-2<CR>")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", { silent = true })

-----
-- append/prepend visual
vim.keymap.set("x", "<C-a>", function()
  local arg = vim.fn.input("append: ")
  feedkeys(": '<,'>normal A" .. arg .. "<CR>", "v", true)
end)
vim.keymap.set("x", "<C-i>", function()
  local arg = vim.fn.input("prepend: ")
  feedkeys(": '<,'>normal I" .. arg .. "<CR>", "v", true)
end)

-----
-- window nav
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-w>w", "<C-w>w")
vim.keymap.set("n", "<A-=>", "<C-W>=")
vim.keymap.set("n", "<A-_>", "<C-W>_")
vim.keymap.set("n", "<A-|>", "<C-W>|")

-----
-- buffer nav
vim.keymap.set("n", "<A-h>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>bnext<CR>")

-----
-- terminal nav
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>cd", function()
  vim.cmd("lcd %:p:h")
end)

-----
-- compilation
vim.keymap.set("n", "<leader>?", ":Compile<cr>")
vim.keymap.set("n", "<leader>>", ":make<cr>")

local function bangbuf(cmd)
  -- write objdump to new file
  vim.cmd("vsp")
  local target_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(target_buf)
  vim.cmd("read !" .. cmd)
end

vim.keymap.set("n", "<leader>so", function()
  cmd = vim.fn.input(":buf!")
  if cmd == "" then
    return
  else
    bangbuf(cmd)
  end
end)

-- write hex to new file
vim.keymap.set("n", "<leader>x", function()
  local source_buf = vim.api.nvim_get_current_buf()
  local data = vim.api.nvim_buf_get_lines(source_buf, 0, -1, false)
  local target_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, data)
  vim.api.nvim_set_current_buf(target_buf)
  feedkeys(":%!xxd<cr>", "n", true)
  vim.g.hexmode = true
end)

-- toggle current file
vim.g.hexmode = false
vim.keymap.set("n", "<leader>X", function()
  if vim.g.hexmode == false then
    feedkeys(":%!xxd<cr>", "n", true)
  else
    feedkeys(":%!xxd -r<cr>", "n", true)
  end
  vim.g.hexmode = not vim.g.hexmode
end)

-----
-- lsp
-- stylua: ignore start
vim.keymap.set("n", "gb", "<C-O>")
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "gi", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "ge", function() vim.diagnostic.open_float({ scope = "line" }) end)
vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end)

-- make a new file path from a word
-- ie ./folder/newrelativefile.txt
local function makeNewFile()
  local word = vim.fn.expand("<cWORD>")
  local newpath = word:match("[.~]*/[%w/]+")
  local choice = vim.fn.confirm(newpath, "create file? &yes\n&no")
  if choice == 1 then
    feedkeys(":e " .. newpath .. "<cr>", "n", true)
  end
end
vim.keymap.set("n", "gnf", function() makeNewFile() end )
-- stylua: ignore end

-----
-- hacks

-- macro wrapper
vim.keymap.set("n", "<leader>m", function()
  local register = vim.fn.getchar(-1, { number = false })
  vim.cmd("WhiskDisable")
  for _ = 1, vim.v.count1 do
    vim.cmd("normal! @" .. register)
  end
  vim.cmd("WhiskEnable")
end)

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
--[[

todo
(./lua/plugins/align.lua)

-----
-- toggles
| keys | command |
|--|--|
| "<leader>w"| stripwhitespace |
| "<leader>f"| otree|
| "<leader>o"| outline|
| "<leader>d"| dashboard|
| "<leader>u"| undotree|

-----
[leap](./init.lua)
(s)kip to (2 letter search)
| keys | command |
|--|--|
| s | leap forward |
| S | leap backward |

-----
[notify](./lua/plugins/notify.lua)
| keys | command |
|--|--|
| "<ESC>" | dismiss notification  |

---
[auto session](./lua/plugins/autosession.lua)
| keys | command |
|--|--|
| "<leader>at"  | toggle |
| "<leader>as"  | save   |
| "<leader>ad"  | delete |

---
[telescope commands](./lua/plugins/telescope.lua)
| keys | command |
|--|--|
| "<leader>tf" | files     |
| "<leader>tr" | recent    |
| "<leader>tg" | git       |
| "<leader>tl" | live      |
| "<leader>tb" | buffers   |
| "<leader>th" | help      |
| "<leader>td" | directory |
| "<leader>ts" | session   |
| "<leader>tw" | word      |
| "<leader>tc" | color     |

---
[toggleterm](./lua/plugins/toggleterm.lua) | keys | command | |--|--| | "<C-t>" | toggle the term |
--- [treesitter-textobjects](./lua/plugins/treesitter.lua)
| action | keys | command |
| --- | --- | ---|
| select | "am" | after function |
| | "im" | inside function |
| | "ac" | after class |
| | "ic" | inside class |
| swap | "<leader>a" | rotate args |
|  | "<leader>A" | rotate args |
| move | "]m" | goto next function |
| | "[m" | goto prev function |
| | "]M" | goto end of next function |
| | "[M" | goto end of prev function |
| | "\]\]" | goto next class |
| | "[]" | goto prev class |
| | "][" | goto end of next class |
| | "[[" | goto end of prev class |
| | "]o" | goto next loop|
| | "]s" | goto next scope|
| | "]z" | goto next fold |
| | "]?" | goto next condition |
| | "[?" | goto previous condition |

---
[oil](./lua/plugins/oil.lua)
only for oil buffers
| key | command |
|--|--|
| ["g?"]    | show_help     |
| ["<CR>"]  | select        |
| ["<A-s>"] | select        |
| ["<A-f>"] | select        |
| ["<A-p>"] | preview       |
| ["<A-c>"] | close         |
| ["-"]     | parent        |
| ["_"]     | open_cwd      |
| ["`"]     | cd            |
| ["g~"]    | cd            |
| ["gs"]    | change_sort   |
| ["gx"]    | open_external |
| ["g."]    | toggle_hidden |
| ["g\\"]   | toggle_trash  |
| ["<A-h>"] | select        |
| ["<A-l>"] | refresh       |


---
[otree](lua/plugins/otree.lua)

| key | command |
| -- | -- |
| ["<CR>"] | select          |
| ["l"] | select             |
| ["h"] | close_dir          |
| ["<C-c>"] | close_win      |
| ["<C-q>"] | close_win      |
| ["<C-t>"] | close_win      |
| ["-"] | goto_parent        |
| ["<C-d>"] | goto_dir       |
| ["<M-h>"] | goto_home_dir  |
| ["cd"] | change_home_dir   |
| ["L"] | open_dirs          |
| ["H"] | close_dirs         |
| ["o"] | oil_dir            |
| ["O"] | oil_into_dir       |
| ["\|"]  | open_vsplit        |
| ["_"] | open_split         |
| ["."] | toggle_hidden      |
| ["i"] | toggle_ignore      |
| ["r"] | refresh            |
| ["f"] | focus_file         |
| ["?"] | open_help          |

]]

-----
-- toggles
vim.keymap.set("n", "<leader>w", "<cmd>StripWhitespace<CR>")
-- vim.keymap.set("n", "<leader>f", "<cmd>Otree<CR>")
vim.g.otreeopen = false -- default is false
vim.keymap.set("n", "<leader>f", function()
  vim.g.otreeopen = not vim.g.otreeopen
  print(vim.g.otreeopen)
  vim.cmd("Otree")
end)
vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>Dashboard<CR><cmd>DisableWhitespace<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")

-----
-- leap (s)kip to (2 letter search)
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")

-----
-- notify clear
vim.keymap.set("n", "<Esc>", ':lua require("notify").dismiss()<CR>', { silent = true })

-----
-- nvim-treesitter-textobjects

-- select
-- function blocks
vim.keymap.set({ "x", "o" }, "am", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "im", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
-- class blocks
vim.keymap.set({ "x", "o" }, "ac", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)

-- swap arguments
vim.keymap.set("n", "<leader>a", function()
  require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>A", function()
  require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
end)

-- move
-- functions next / previous
vim.keymap.set({ "n", "x", "o" }, "]m", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]M", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[M", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end)

-- class next / previous
vim.keymap.set({ "n", "x", "o" }, "]]", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
  require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
  require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end)

-- next loop
vim.keymap.set({ "n", "x", "o" }, "]o", function()
  require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
end)
-- next scope
vim.keymap.set({ "n", "x", "o" }, "]s", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
end)
-- next fold
vim.keymap.set({ "n", "x", "o" }, "]z", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
end)

-- next / previous condition
vim.keymap.set({ "n", "x", "o" }, "]?", function()
  require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[?", function()
  require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
end)

-- todo
--
-- dap commands
--
-- local dap = require("dap")
-- local dapui = require("dapui")
-- --
-- vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<cr>")
-- vim.keymap.set("n", "<leader><", function()
-- 	dapui.toggle()
-- end)
-- -- -- vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
-- -- -- vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
-- -- -- vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
-- -- -- vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
-- vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
-- vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
-- vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
-- vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
