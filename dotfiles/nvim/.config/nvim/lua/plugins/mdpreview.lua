-- install without yarn or npm
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  -- build = "cd app && npm install",
  build = function()
    vim.cmd([[Lazy load markdown-preview.nvim]])
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.cmd([[
      function OpenMarkdownPreview (url)
        execute ":silent ! firefox " . a:url
      endfunction
    ]])
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  end,
}

-- for wsl
-- vim.cmd([[
--   function OpenMarkdownPreview (url)
--     execute "! /mnt/c/Program\\\ Files/Google/Chrome/Application/chrome.exe " . a:url
--   endfunction
-- ]])
