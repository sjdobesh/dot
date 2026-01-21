-- lsp
-- load after plugins!

local mason_lsps = {

  -- "lua is handled by lazydev"
  "bashls",
  "clangd",
  "glsl_analyzer",
  "rust_analyzer",
}

return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = mason_lsps,
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
  },
}
