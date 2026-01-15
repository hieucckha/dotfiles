return {
  {
    "f4z3r/gruvbox-material.nvim",
    name = "gruvbox-material",
    lazy = false,
    priority = 1000,
    opts = {
      background = {
        transparent = true,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "gruvbox-material",
        component_separators = { left = " ", right = " " },
        section_separators = { left = " ", right = " " },
      },
    },
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      explorer = {
        replace_netrw = true,
        trash = true,
      },
      indent = { },
      picker = { },
    },
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
        desc = "File Explorer"
      },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    }
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
