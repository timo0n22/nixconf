return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.45,
          },
          width = 0.95,
          height = 0.90,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      }
    })

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
  end
}
