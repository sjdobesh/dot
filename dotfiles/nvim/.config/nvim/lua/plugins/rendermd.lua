-- [MeanderingProgrammer/render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim),

return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } },
    win_options = {
      conceallevel = { default = vim.o.conceallevel, rendered = 3 },
      concealcursor = { default = vim.o.concealcursor, rendered = "" },
    },
    file_types = { "bash", "org", "markdown", "lua", "html", "c", "h" },
    injections = {
      lua = {
        enabled = true,
        query = [[
                ((comment_content) @injection.content
                    (#offset! @injection.content 0 0 0 1)
                    (#set! injection.language "markdown"))
            ]],
      },
      c = {
        enabled = true,
        query = [[
                ((comment) @injection.content
                    (#offset! @injection.content 0 3 0 0)
                    (#set! injection.language "markdown"))
            ]],
      },
      -- h = {
      --   enabled = true,
      --   query = [[
      --           ((comment_content) @injection.content
      --               (#offset! @injection.content 0 0 0 1)
      --               (#set! injection.language "markdown"))
      --       ]],
      -- },
      -- bash = {
      --   enabled = true,
      --   query = [[
      --           ((comment_content) @injection.content
      --               (#offset! @injection.content 0 0 0 1)
      --               (#set! injection.language "markdown"))
      --       ]],
      -- },
    },
  },
}
-- (#set! injection.include-children)
