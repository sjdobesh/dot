----------------------------------------/
--    _____   _   ___    ________  ___  |
--   / ___/  / | / / |  / /  _/  |/  /  |
--   \__ \  /  |/ /| | / // // /|_/ /   |
--  ___/ / / /|  / | |/ // // /  / /    |
-- /____(_)_/ |_/  |___/___/_/  /_/     |
--                                      /
----------------------------------------------------------------------------(80)

-- PLUGINS ---------------------------------------------------------------------

vim.cmd("filetype plugin on")

-- stylua: ignore
local plugins = {

  -- load colorschemes first
  require("configs.colorschemes"),

  -- simple configuration plugins
  { "https://codeberg.org/andyg/leap.nvim" }, -- leap command
  { "mbbill/undotree" },                      -- branching undo tree
  { "tpope/vim-repeat" },                     -- add repeat command to plugins
  { "tpope/vim-fugitive" },                   -- (:G)it integration
  { "tpope/vim-repeat" },                     -- plugin integrated dot command
  { "airblade/vim-gitgutter" },               -- git gutter in sign column
  { "tpope/vim-surround" },                   -- (s)urround command
  { "tpope/vim-commentary" },                 -- comment selections
  { "ntpeters/vim-better-whitespace" },       -- whitespace management
  { "nvim-tree/nvim-web-devicons" },          -- icons (common dependency)

  -- external configuration plugins
  require("plugins.autosession"), -- reload session data
  require("plugins.compilebuf"),  -- compilation buffer
  require("plugins.dashboard"),   -- start screen
  require("plugins.glimmer"),     -- command animations
  require("plugins.imgpreview"),  -- image previews
  require("plugins.luaconsole"),  -- lua scratch pad
  require("plugins.lualine"),     -- status line and tabs
  require("plugins.whisk"),       -- movement animations
  require("plugins.mdpreview"),   -- render markdown into a browser
  require("plugins.neorg"),       -- org mode
  require("plugins.oil"),         -- file viewer/editor
  require("plugins.outline"),     -- symbol viewer
  require("plugins.otree"),       -- file tree
  require("plugins.rendermd"),    -- render markdown in terminal
  require("plugins.scope"),       -- scope/indent outliner
  require("plugins.telescope"),   -- fuzzy finder
  require("plugins.toggleterm"),  -- persistent term
  require("plugins.treesitter"),  -- syntax parser
  require("plugins.yanky"),       -- yank and put manager

  -- lsp configurations (do last)
  require("plugins.mason"),   -- lsp manager
  require("plugins.conform"), -- formatter
  -- require("plugins.dap"),     -- debugger adapter protocol

}

-- lazy ------------------------------------------------------------------------

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
			{ out, "WarningMsg" },
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
		plugins, -- plugin table acquired through require commands above
	},
	{ checker = { enabled = true } }, -- auto update
})

-- config files ----------------------------------------------------------------

require("configs.options")
require("configs.keymaps")
