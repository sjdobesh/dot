-- (https://github.com/rmagatti/auto-session)
local function feedkeys(keys, mode, escape_ks)
  local replaced_keys = vim.api.nvim_replace_termcodes(keys, true, true, escape_ks)
  vim.api.nvim_feedkeys(replaced_keys, mode, escape_ks)
end
return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>at", "<cmd>AutoSession toggle<CR>" },
    { "<leader>as", "<cmd>AutoSession save<CR>" },
    { "<leader>ad", "<cmd>AutoSession delete<CR>" },
  },
  config = function()
    require("auto-session").setup({
      suppressed_dirs = {
        "/",
        "~/",
        "~/bin",
        "~/docs",
        "~/repos",
        "~/public",
      },

      save_extra_data = function(_)
        return vim.fn.json_encode({ otree = vim.g.neotreeopen })
      end,

      restore_extra_data = function(_, extra_data)
        vim.g.neotreeopen = vim.fn.json_decode(extra_data).otree
      end,

      post_restore_cmds = {
        function()
          if vim.g.neotreeopen == true then
            feedkeys(":Neotree toggle<cr><C-w>l", "n", true)
          end
        end,
      },
    })
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
}
