-- INFO: fuzzy finder
local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
    vim.system({ "make" }, { cwd = ev.data.path }):wait()
  end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",         -- library dependency
  "https://github.com/nvim-tree/nvim-web-devicons",   -- icons (nerd font)
  "https://github.com/nvim-telescope/telescope.nvim", -- the fuzzy finder
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
}, { confirm = false })

require("telescope").setup({})

local pickers = require("telescope.builtin")

vim.keymap.set("n", "<leader>fp", pickers.builtin, { desc = "[S]earch Builtin [P]ickers" })
vim.keymap.set("n", "<leader>fb", pickers.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>ff", pickers.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>fw", pickers.grep_string, { desc = "[S]earch Current [W]ord" })
vim.keymap.set("n", "<leader>fg", pickers.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>fr", pickers.resume, { desc = "[S]earch [R]esume" })

vim.keymap.set("n", "<leader>fh", pickers.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>fm", pickers.man_pages, { desc = "[S]earch [M]anuals" })

