--- -- -    ______    ________  ___
--   / ___/ |  / /  _/  |/  /
--   \__ \| | / // // /|_/ /
--  ___/ /| |/ // // /  / /
-- /____(_)___/___/_/  /_/
--
----------------------------------------------------------------------------(80)


-- PLUGINS ---------------------------------------------------------------------

local plugins = {

  -- simple configuration plugins
  { "tpope/vim-surround"   },           -- (s)urround command
  { "tpope/vim-commentary" },           -- group comments
  { "tpope/vim-fugitive" },             -- vim git integration
  { "hedyhli/outline.nvim" },           -- symbol viewer
  { "mbbill/undotree" },                -- branching undo tree
  { "nvim-tree/nvim-web-devicons"    }, -- icons (common dependency)
  { "ntpeters/vim-better-whitespace" }, -- whitespace management

  -- external configuration plugins
  require("plugins.dashboard"), -- file viewer/editor
  require("plugins.lazydev"),   -- file viewer/editor
  require("plugins.lualine"),   -- status line and tabs
  require("plugins.oil"),       -- file viewer/editor
  require("plugins.telescope"), -- status line and tabs
  require("plugins.blink"),     -- autocomplete
  require("plugins.mason"),     -- lsp info (load last to acquire other plugin maps)

  -- colorschemes
  require("configs.colorschemes"),

}
-- -- lazy ------------------------------------------------------------------------
--
-- install lazy loader if not available
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({dashboard
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup(
  plugins, -- plugin table acquired through require commands above
  { checker = { enabled = true,}} -- auto update
)

-- options ---------------------------------------------------------------------

require("configs.options")

-- key maps --------------------------------------------------------------------

require("configs.keymaps")

