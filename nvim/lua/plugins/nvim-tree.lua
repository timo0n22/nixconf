return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        side = "left",
        width = 35,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_label = true,
        indent_markers = { enable = true },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end,
}

