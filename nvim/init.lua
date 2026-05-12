-- References: https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua

-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = true
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = "yes"
-- sweet sweet relative line numbers
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = "list:longest"
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"
-- tabs: go big or go home
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.tabstop = 8
vim.opt.expandtab = false
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append("iwhite")
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
-- enable true color support
vim.opt.termguicolors = true
-- enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
-- don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- sync clipboard between OS and Neovim
-- see `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"
-- enable break indent
vim.opt.breakindent = true
-- decrease update time
vim.opt.updatetime = 250
-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300
-- sets how neovim will display certain whitespace characters in the editor
-- See `:help 'list'`
-- and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", lead = "·", trail = "·", nbsp = "␣" }
-- preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- show which line your cursor is on
vim.opt.cursorline = true
-- set highlight on search, but clear on pression <Esc> in normal mode
vim.opt.hlsearch = true

-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-------------------------------------------------------------------------------
--
-- configuring diagnostics
--
-------------------------------------------------------------------------------
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
	virtual_text = true, -- show inline diagnostics
	virtual_lines = false,
})

-------------------------------------------------------------------------------
--
-- autocommands
--
-------------------------------------------------------------------------------
-- highlight trailing whitespace
vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "LightRed" })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]],
})
-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
})
-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup("text", { clear = true })
for _, pat in ipairs({ "text", "markdown", "mail", "gitcommit" }) do
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = pat,
		group = text,
		command = "setlocal spell tw=72 colorcolumn=73",
	})
end

-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
-- main color scheme
vim.pack.add({ "https://github.com/wincent/base16-nvim" }, { confirm = false })
vim.cmd.colorscheme("gruvbox-dark-hard")
vim.o.background = "dark"
-- less visible window separator
vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
-- Make comments more prominent -- they are important.
local bools = vim.api.nvim_get_hl(0, { name = "Boolean" })
vim.api.nvim_set_hl(0, "Comment", bools)
-- Make it clearly visible which argument we're at.
local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
vim.api.nvim_set_hl(
	0,
	"LspSignatureActiveParameter",
	{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
)
-- nice bar at the bottom
vim.pack.add({ "https://github.com/wincent/base16-nvim" }, { confirm = false })
vim.pack.add({ "https://github.com/itchyny/lightline.vim" }, { confirm = false })
vim.o.showmode = false
vim.g.lightline = {
	active = {
		left = {
			{ "mode", "paste" },
			{ "readonly", "filename", "modified" },
		},
		right = {
			{ "lineinfo" },
			{ "percent" },
			{ "fileencoding", "filetype" },
		},
		component_function = {
			filename = "LightlineFilename",
		},
	},
}
function LightlineFilenameInLua(opts)
	if vim.fn.expand("%:t") == "" then
		return "[No Name]"
	else
		return vim.fn.getreg("%")
	end
end

-- https://github.com/itchyny/lightline.vim/issues/657
vim.api.nvim_exec(
	[[
	function! g:LightlineFilename()
		return v:lua.LightlineFilenameInLua()
	endfunction
	]],
	true
)
-- fzf support for ^p
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" }, { confirm = false })
-- stop putting a giant window over my editor
require("fzf-lua").setup({
	winopts = {
		split = "belowright 10new",
		preview = {
			hidden = true,
		},
	},
	files = {
		-- file icons are distracting
		file_icons = false,
		-- git icons are nice
		git_icons = true,
		-- but don't mess up my anchored search
		_fzf_nth_devicons = true,
	},
	buffers = {
		file_icons = false,
		git_icons = true,
		-- no nth_devicons as we'll do that
		-- manually since we also use
		-- with-nth
	},
	fzf_opts = {
		-- no reverse view
		["--layout"] = "default",
	},
})
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Find files in project" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "Search text in project" })
-- use fzf to search buffers as well
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers({
		-- just include the paths in the fzf bits, and nothing else
		-- https://github.com/ibhagwan/fzf-lua/issues/2230#issuecomment-3164258823
		fzf_opts = {
			["--with-nth"] = "{-3..-2}",
			["--nth"] = "-1",
			["--delimiter"] = "[:\u{2002}]",
			["--header-lines"] = "false",
		},
		header = false,
	})
end, { desc = "List open buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").oldfiles()
end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>f?", function()
	require("fzf-lua").help_tags()
end, { desc = "Search help tags" })
vim.keymap.set("n", "<leader>fr", function()
	require("fzf-lua").resume()
end, { desc = "Resume last fzf-lua picker" })
-- LSP
vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
}, { confirm = false })

-- ensure lsp servers and formatters is installed
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "stylua", "gopls" },
})

-- Setup language servers

-- lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- golang

-- Global mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end, opts)

		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		-- TODO: find some way to make this only apply to the current line.
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
		end

		-- None of this semantics tokens business.
		-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
		client.server_capabilities.semanticTokensProvider = nil

		-- format on save
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
-- code-completion
vim.pack.add({ "https://github.com/saghen/blink.lib", "https://github.com/saghen/blink.cmp" }, { confirm = false })
local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			auto_show = true,
			treesitter_highlighting = true,
			window = { border = "rounded" },
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
	signature = {
		enabled = false,
	},
	keymap = {
		-- these are the default blink keymaps
		["<C-n>"] = { "select_next", "fallback_to_mappings" },
		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		["<C-y>"] = { "select_and_accept", "fallback" },
		["<C-e>"] = { "cancel", "fallback" },

		["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		["<CR>"] = { "select_and_accept", "fallback" },
		["<Esc>"] = { "cancel", "hide_documentation", "fallback" },

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },

		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
	},
})
-- file pickers
vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { confirm = false })
require("oil").setup({
	columns = { "icon" },
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<space>-", require("oil").toggle_float)
-- utility plugins
vim.pack.add({
	"https://github.com/folke/which-key.nvim", -- help remember the key
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/windwp/nvim-autopairs", -- auto pairs
	"https://github.com/andymass/vim-matchup", -- better %
	"https://github.com/ray-x/lsp_signature.nvim", -- inline function signatures
}, { confirm = false })
require("which-key").setup({
	spec = {
		{ "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
	},
})
require("nvim-autopairs").setup()
vim.g.matchup_matchparen_offscreen = { method = "popup" }
require("lsp_signature").setup({
	doc_lines = 0,
	handler_opts = {
		border = "none",
	},
})
