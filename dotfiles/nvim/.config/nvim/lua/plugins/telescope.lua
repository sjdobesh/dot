return {
  { "zane-/cder.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    keys = {
      { "<leader>tf", "<cmd>Telescope find_files<cr>", { desc = "all files" } },
      { "<leader>to", "<cmd>Telescope oldfiles<cr>", { desc = "old files" } },
      { "<leader>tr", "<cmd>Telescope lsp_references<cr>", { desc = "lsp references" } },
      { "<leader>tg", "<cmd>Telescope live_grep<CR>", { desc = "live grep" } },
      { "<leader>tb", "<cmd>Telescope buffers<CR>", { desc = "buffers" } },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", { desc = "help tags" } },
      { "<leader>td", "<cmd>Telescope cder<CR>", { desc = "directories" } },
      { "<leader>ts", "<cmd>Telescope session-lens<CR>", { desc = "sessions" } },
      { "<leader>tw", '<cmd>Telescope grep_string cwd="~"', { desc = "word" } },
      {
        "<leader>tc",
        function()
          require("telescope.builtin").colorscheme({
            ignore_builtins = true,
            previewer = false,
            -- list colorschemes to ignore
            file_ignore_patterns = {
              "^lux$",
              "eos",
              "chroma",
              "aurora",
              "^kanagawa$",
              "lotus",
              "lite",
              "light",
              "Light",
              "^github$",
              "pyte",
              "rdark-terminal2",
              "lucius",
              "-latte",
              "dawn",
              "day",
            },
          })
        end,
      },
    },
    tag = "v0.2.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "descending",
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
            layout_config = {
              height = 0.4,
              width = 0.4,
              prompt_position = "top",
              preview_cutoff = 0,
            },
            layout_strategy = "center",
          },
        },
        extensions = {
          cder = {
            dir_command = {
              "fd ",
              "-L ",
              "--hidden ",
              "--type=d ",
              ". ",
              os.getenv("HOME"),
            },
            previewer_command = "eza "
              .. "-a "
              .. "--color=always "
              .. "-T "
              .. "--level=3 "
              .. "--icons "
              .. "--git-ignore "
              .. "--long "
              .. "--no-permissions "
              .. "--no-user "
              .. "--no-filesize "
              .. "--git "
              .. "--ignore-glob=.git",
            entry_maker = function(line)
              return {
                value = line,
                display = function(entry)
                  return " " .. line:gsub(os.getenv("HOME") .. "/", ""), { { { 1, 3 }, "Directory" } }
                end,
                ordinal = line,
              }
            end,
          },
        },
      })
      require("telescope").load_extension("cder")
    end,
  },
}
