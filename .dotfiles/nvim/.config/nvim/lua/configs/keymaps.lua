-- s.nvim keymaps

-- helpers -------------------------------------------------------------------80

-- uses nvim api to recreate normal key functionality
-- usefule for conditional mappings
local function feedkeys(keys, mode, escape_ks)
  local replaced_keys = vim.api.nvim_replace_termcodes(keys, true, true, escape_ks)
  vim.api.nvim_feedkeys(replaced_keys, mode, escape_ks)
end

-- core ----------------------------------------------------------------------80

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- quit / refresh
vim.keymap.set({"n", "i"}, "<C-q>",     "<cmd>q!<CR>")
vim.keymap.set({"n", "i"}, "<C-c>",     "<cmd>close!<CR>")
vim.keymap.set({"n", "i"}, "<C-b>",     "<cmd>bd!<CR>")
vim.keymap.set( "n",       "<leader>/", "<cmd>noh<CR>")
vim.keymap.set( "n",       "<leader>r", "<cmd>restart<CR>")

-- move selection
vim.keymap.set({"n", "i"}, "<A-j>", "<cmd>m+<CR>")
vim.keymap.set({"n", "i"}, "<A-k>", "<cmd>m-2<CR>")
vim.keymap.set( "v",       "<A-j>", "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set( "v",       "<A-k>", "<cmd>m '<-2<CR>gv=gv")

-- window nav
vim.keymap.set("n", "<C-h>",  "<C-w>h")
vim.keymap.set("n", "<C-j>",  "<C-w>j")
vim.keymap.set("n", "<C-k>",  "<C-w>k")
vim.keymap.set("n", "<C-l>",  "<C-w>l")
vim.keymap.set("n", "<C-w>w", "<C-w>w")
vim.keymap.set("n", "<A-=>",  "<C-W>=")
vim.keymap.set("n", "<A-_>",  "<C-W>_")
vim.keymap.set("n", "<A-|>",  "<C-W>|")

-- buffer nav
vim.keymap.set("n", "<A-h>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>bnext<CR>")

-- terminal nav
vim.keymap.set({"t", "n"}, "<C-t>",      "<Cmd>ToggleTerm<CR>")
vim.keymap.set( "t",       "<C-q>",      "<C-\\><C-n>")
vim.keymap.set( "n",       "<leader>cd", function() vim.cmd("lcd %:p:h") end)

-- the perfect comment seperator
vim.keymap.set(
  "n", "<leader>8",
  function()
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
  end
)

-- lsp commands
-- gd - go to definition
-- gb - go back
-- ge - get error
-- gi - get info
-- gr - get references

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "gb", "<C-O>")
vim.keymap.set("n", "gi", function() vim.lsp.buf.hover() end)
vim.keymap.set("n", "ge", function() vim.diagnostic.open_float({scope="line"}) end)
vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end)

-- toggles

vim.keymap.set("n", "<leader>w",  "<cmd>StripWhitespace<CR>")
vim.keymap.set("n", "<leader>f",  "<cmd>Otree<CR>")
vim.keymap.set("n", "<leader>o",  "<cmd>Outline<CR>")
vim.keymap.set("n", "<leader>d",  "<cmd>Dashboard<CR>:DisableWhitespace<CR>")
vim.keymap.set("n", "<leader>u",  "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>at", "<cmd>AutoSession toggle<CR>")
vim.keymap.set("n", "<leader>as", "<cmd>AutoSession save<CR>")
vim.keymap.set("n", "<leader>ad", "<cmd>AutoSession delete<CR>")

-- fuzzy finding keymaps

-- telescope commands
-- (f)iles
-- (r)ecent
-- (g)it
-- (l)ive
-- (b)uffers
-- (h)elp
-- (d)irectory
-- (s)ession
-- (w)ord
-- (c)olor

local tele_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", tele_builtin.find_files)
vim.keymap.set("n", "<leader>tr", tele_builtin.oldfiles)
vim.keymap.set("n", "<leader>tg", tele_builtin.git_files)
vim.keymap.set("n", "<leader>tl", tele_builtin.live_grep)
vim.keymap.set("n", "<leader>tb", tele_builtin.buffers)
vim.keymap.set("n", "<leader>th", tele_builtin.help_tags)
vim.keymap.set("n", "<leader>td", "<cmd>Telescope cder<CR>")
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope session-lens<CR>")
vim.keymap.set(
  {"v", "n"}, "<leader>tw",
  function() tele_builtin.grep_string({cwd = "~"}) end
)
vim.keymap.set(
  {"v", "n"}, "<leader>tc",
  function()
    tele_builtin.colorscheme({
      ignore_builtins = true,
      previewer = false,
      -- list colorschemes to ignore
      file_ignore_patterns = {
        "^lux$",
        "eos",
        "chroma",
        "aurora",
        "^kanagawa$",
        "lotus",
        "lite",
        "light",
        "Light",
        "^github$",
        "pyte",
        "rdark-terminal2",
        "lucius",
      },
    })
  end
)


-- lux animations

-- lux animation plugin smooths cursor movement but also prevents
-- holding down to feed keys. this means you can't hold j to go down
-- the following creates a conditional mapping to disable plugin
-- functionality on single movements

-- disable smoothing when a commands v.count == 0
local orchestrator = require("luxmotion.engine.orchestrator")
local function conditional_smooth_move(key)
  if vim.v.count == 0 then
    feedkeys(key, "n", true) -- recreate normal functionality
  else
    return orchestrator.execute("basic_"..key, { count = vim.v.count1, direction = key })
  end
end

-- map buttons you want to spam
vim.keymap.set("n", "j", function() conditional_smooth_move("j") end)
vim.keymap.set("n", "k", function() conditional_smooth_move("k") end)
vim.keymap.set("n", "l", function() conditional_smooth_move("l") end)
vim.keymap.set("n", "h", function() conditional_smooth_move("h") end)
