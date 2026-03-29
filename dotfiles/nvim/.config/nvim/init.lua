-- # s.nvim init
-- [github](https://github.com/sjdobesh/dot)
------------------------------------------------------------------------------80
--[[

main init.lua for my nvim rice
## toc
  - [plugins](./lua/plugins/)
  - [keymaps](./lua/configs/keymaps.lua)
  - [options](./lua/configs/options.lua)
  - [colorschemes](./lua/configs/colorschemes.lua)

]]
-- ---
-- ## [plugin table](./ftplugin/c.lua)
-- stylua: ignore
local plugins = {

  -- load colorschemes first
  require("configs.colorschemes"),

  -- mandatory tpope plug set
  { "tpope/vim-repeat" },     -- plugin integrated dot command
  { "tpope/vim-surround" },   -- (s)urround command
  { "tpope/vim-fugitive" },   -- (:G)it integration
  { "tpope/vim-commentary" }, -- comment selections

  -- other simple config plugins
  { "mbbill/undotree" },                      -- branching undo tree
  { "j-hui/fidget.nvim" },                    -- fidget for lsp progress
  { "airblade/vim-gitgutter" },               -- git gutter in sign column
  { "nvim-tree/nvim-web-devicons" },          -- icons (common dependency)
  { "ntpeters/vim-better-whitespace" },       -- whitespace management
  { "https://codeberg.org/andyg/leap.nvim" }, -- leap command (sneak but better)

  -- external configuration plugins
  require("plugins.align"),       -- align by X (ala EMACS)
  require("plugins.autosession"), -- reload session data
  require("plugins.compilebuf"),  -- compilation buffer
  require("plugins.conform"),     -- formatter
  require("plugins.dashboard"),   -- start screen
  require("plugins.glimmer"),     -- command animations
  -- require("plugins.imgpreview"),  -- image previews
  require("plugins.luaconsole"),  -- lua scratch pad
  require("plugins.lualine"),     -- status line and tabs
  require("plugins.mason"),       -- lsp manager
  require("plugins.mdpreview"),   -- render markdown into a browser
  require("plugins.neorg"),       -- org mode
  require("plugins.neotree"),     -- file tree
  require("plugins.notify"),      -- nice notification
  require("plugins.oil"),         -- file viewer/editor
  require("plugins.outline"),     -- symbol viewer
  require("plugins.rendermd"),    -- render markdown in terminal
  require("plugins.scope"),       -- scope/indent outliner
  require("plugins.telescope"),   -- fuzzy finder
  require("plugins.timers"),      -- timer manager
  require("plugins.toggleterm"),  -- persistent term
  require("plugins.treesitter"),  -- syntax parser
  require("plugins.linkview"),    -- link manager
  require("plugins.yanky"),       -- kill ring
}

-----
-- ## lazy

-- make sure these are available to lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup({
  spec = {
    plugins,                        -- plugin table acquired through require commands above
  },
  { checker = { enabled = true } }, -- auto update
})

-----
-- ## load other config files

require("configs.options")
require("configs.keymaps")
