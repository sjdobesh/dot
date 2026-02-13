return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ':TSUpdate',
  config = function ()
    require'nvim-treesitter'.install {
      "cpp",
      "glsl",
      "bash",
      "javascript",
      "rust",
    }
    vim.api.nvim_create_autocmd('FileType',
      {
        pattern = { '<filetype>' },
        callback = function() vim.treesitter.start() end,
      }
    )
  end
}
