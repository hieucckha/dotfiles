return {
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>ft",
        function()
          local explorer_pickers = Snacks.picker.get({ source = "explorer" })
          if #explorer_pickers == 0 then
            Snacks.picker.explorer()
          else
            explorer_pickers[1]:focus()
          end
        end,
        desc = "File Explorer",
      },
    },
  },
}
