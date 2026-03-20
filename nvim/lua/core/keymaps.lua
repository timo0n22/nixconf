local function setup_keymaps()
  vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
  end)

  -- on off wrap
  vim.keymap.set("n", "<leader>wo", ":set wrap<CR>", { desc = "Включить wrap" })
  vim.keymap.set("n", "<leader>wn", ":set nowrap<CR>", { desc = "Отключить wrap" })

  -- Движение строк
  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

  -- Центрирование вида
  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")
  vim.keymap.set("n", "n", "nzzzv")
  vim.keymap.set("n", "N", "Nzzzv")

  -- Копирование в системный буфер
  vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
  vim.keymap.set("n", "<leader>Y", [["+Y]])

  -- Навигация по ошибкам
  vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
  vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
  vim.keymap.set("n", "<C-S-k>", "<cmd>lnext<CR>zz")
  vim.keymap.set("n", "<C-S-j>", "<cmd>lprev<CR>zz")

  -- Telescope
  vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { desc = "Find symbols" })
  vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>", { desc = "Find references" })

  -- Сохранение и выход
  vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
  vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save quit" })
  vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
  vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Force quit all" })

  -- Буферы
  vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
  vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })

  -- LSP
  local lsp = vim.lsp
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  vim.keymap.set("n", "gd", lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "gr", lsp.buf.references, { desc = "Show references" })
  vim.keymap.set("n", "K", lsp.buf.hover, { desc = "Show documentation" })
  vim.keymap.set("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })
  vim.keymap.set("n", "<leader>f", function() lsp.buf.format({ async = true }) end, { desc = "Format file" })

  -- NvimTree
  vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
  vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })

end

return {
  setup = setup_keymaps
}
