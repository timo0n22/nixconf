vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.conceallevel = 2
vim.opt.guicursor = "n-v-c-i-sm:block,ci-ve:ver25,r-cr-o:hor20"
vim.api.nvim_set_hl(0, "Visual", { bg = "#fffff0", bold = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})
