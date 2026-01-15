return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	{
		"stevearc/conform.nvim",
		lazy = true,
		dependencies = { "mason.nvim" },
		keys = {
			{
				"<leader>cF",
				function()
					require("conform").format({ async = true, lsp_format = "never" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		---@tyle conform.setupOpts
		opts = {
			format_on_save = function(bufnr)
				local lsp_format_opt = "never"
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
			},
		},
	},
}
