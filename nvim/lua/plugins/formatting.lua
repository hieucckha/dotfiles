--INFO: formatting
vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
vim.keymap.set({ "n", "v" }, "<leader>cn", "<cmd>ConformInfo<cr>", { desc = "Conform Info" })
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true }, function(err, did_edit)
    if not err and did_edit then
      vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
    end
  end)
end, { desc = "Format buffer" })
vim.keymap.set({ "n", "v" }, "<leader>cF", function()
  require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })

