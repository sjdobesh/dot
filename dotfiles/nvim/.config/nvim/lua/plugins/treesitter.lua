return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "cpp",
        "c",
        "glsl",
        "javascript",
        "lua",
        "rust",
        "markdown",
        "markdown_inline",
        -- "norg",
        "html",
        "latex",
        "yaml",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "<filetype>" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- disable entire built-in ftplugin mappings to avoid conflicts.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = {
          -- whether to set jumps in the jumplist
          set_jumps = true,
        },
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- stylua: ignore
					selection_modes = {
						["@parameter.outer"] = "v",     -- charwise
						["@function.outer"]  = "V",     -- linewise
						["@class.outer"]     = "<c-v>", -- blockwise
					},
          include_surrounding_whitespace = false,
        },
      })
    end,
  },
}
