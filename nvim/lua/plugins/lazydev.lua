return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			---@type lazydev.Library.spec[]
			library = {
				{ path = "$VIMRUNTIME" },
				{ path = "/Users/hieu/.local/share/nvim/lazy" },
			},
		},
	},
}
