----------------------------------------/
--    _____   _   ___    ________  ___  |
--   / ___/  / | / / |  / /  _/  |/  /  |
--   \__ \  /  |/ /| | / // // /|_/ /   |
--  ___/ / / /|  / | |/ // // /  / /    |
-- /____(_)_/ |_/  |___/___/_/  /_/     |
--                                      /
----------------------------------------------------------------------------(80)

-- PLUGINS ---------------------------------------------------------------------

 -- stylua: ignore
local plugins = {

	-- load colorschemes first
	require("configs.colorschemes"),

	-- simple configuration plugins
	{ "mbbill/undotree"                }, -- branching undo tree
	{ "tpope/vim-repeat"               }, -- add repeat command to plugins
	{ "tpope/vim-fugitive"             }, -- (:G)it integration
	{ "airblade/vim-gitgutter"         }, -- git gutter in sign column
	{ "tpope/vim-surround"             }, -- (s)urround command
	{ "tpope/vim-commentary"           }, -- comment selections
	{ "ntpeters/vim-better-whitespace" }, -- whitespace management
	{ "nvim-tree/nvim-web-devicons"    }, -- icons (common dependency)

	-- external configuration plugins
	require( "plugins.autosession"     ), -- reload session data
	require( "plugins.dashboard"       ), -- start screen
	require( "plugins.glimmer"         ), -- command animations
	require( "plugins.lualine"         ), -- status line and tabs
	require( "plugins.luxmotion"       ), -- movement animations
	require( "plugins.oil"             ), -- file viewer/editor
	require( "plugins.outline"         ), -- symbol viewer
	require( "plugins.otree"           ), -- file tree
	require( "plugins.scope"           ), -- scope/indent outliner
	require( "plugins.telescope"       ), -- fuzzy finder
	require( "plugins.toggleterm"      ), -- persistent term
	require( "plugins.treesitter"      ), -- syntax parser
	require( "plugins.mason"           ), -- lsp manager
	require( "plugins.conform"         ), -- formatter

}

-- lazy ------------------------------------------------------------------------

-- make sure these are available to lazy
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
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
