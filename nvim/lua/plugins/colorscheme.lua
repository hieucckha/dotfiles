-- INFO: colorscheme

vim.pack.add({ "https://github.com/navarasu/onedark.nvim" }, { confirm = false })
require("onedark").setup({
  style = "deep",
})
vim.cmd.colorscheme("onedark")

