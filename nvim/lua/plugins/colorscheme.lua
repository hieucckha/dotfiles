-- INFO: colorscheme

vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" }, { confirm = false })
require("gruvbox").setup()
vim.cmd.colorscheme("gruvbox")
