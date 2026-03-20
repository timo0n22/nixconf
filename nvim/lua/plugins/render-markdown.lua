return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("render-markdown").setup({
      -- Render markdown in normal mode
      enabled = true,
      -- Maximum file size (in MB) that will be rendered
      max_file_size = 10.0,
      -- Headings
      headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- Bullets for unordered lists
      bullets = { "●", "○", "◆", "◇" },
      -- Checkboxes
      checkbox = {
        unchecked = "󰄱 ",
        checked = "󰄲 ",
      },
      -- Code blocks
      code = {
        -- Highlight code blocks
        enabled = true,
        -- Position of code block title ('left', 'center', 'right')
        position = "left",
        -- Minimum width for code blocks
        width = "block",
      },
    })
  end,
}
