-- INFO: better statusline
--
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { confirm = false })

require("lualine").setup({
	options = {
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	winbar = {
		lualine_a = { "buffers" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "lsp_status" },
	},

	inactive_winbar = {
		lualine_a = { "buffers" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "lsp_status" },
	},
})
