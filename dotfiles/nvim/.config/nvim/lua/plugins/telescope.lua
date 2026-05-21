return {
  { "zane-/cder.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    keys = {
      { "<leader>tf", "<cmd>Telescope find_files<cr>" },
      { "<leader>tr", "<cmd>Telescope oldfiles<cr>" },
      { "<leader>tg", "<cmd>Telescope git_files<cr>" },
      { "<leader>tl", "<cmd>Telescope live_grep<CR>" },
      { "<leader>tb", "<cmd>Telescope buffers<CR>" },
      { "<leader>th", "<cmd>Telescope help_tags<cr>" },
      { "<leader>td", "<cmd>Telescope cder<CR>" },
      { "<leader>ts", "<cmd>Telescope session-lens<CR>" },
      { "<leader>tw", '<cmd>Telescope grep_string cwd="~"' },
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
