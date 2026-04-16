-- INFO: fuzzy finder

-- when install the fzf extension make sure running
-- 'make' command for compile the extension
local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
    vim.system({ "make" }, { cwd = ev.data.path }):wait()
  end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",                    -- library dependency
  "https://github.com/nvim-tree/nvim-web-devicons",              -- icons (nerd font)
  "https://github.com/nvim-telescope/telescope.nvim",            -- the fuzzy finder
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim", -- better performance
}, { confirm = false })

local pickers = require("telescope.builtin")
vim.keymap.set("n", "<leader>fp", pickers.builtin, { desc = "Telescope [P]ickers" })
vim.keymap.set("n", "<leader>fb", pickers.buffers, { desc = "Telescope [B]uffers" })
vim.keymap.set("n", "<leader>ff", pickers.find_files, { desc = "Telescope [F]iles" })
vim.keymap.set("n", "<leader>fw", pickers.grep_string, { desc = "Telescope Current [W]ord" })
vim.keymap.set("n", "<leader>fg", pickers.live_grep, { desc = "Telescope by [G]rep" })
vim.keymap.set("n", "<leader>fr", pickers.resume, { desc = "Telescope [R]esume" })

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    path_display = { "filename_first" },
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    },
  },
})
telescope.load_extension("fzf")

