vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap", -- Debug adapter
	"https://github.com/Cliffback/netcoredbg-macOS-arm64.nvim", -- netcoredbg buld for arm64
	"https://github.com/rcarriga/nvim-dap-ui", -- Debug UI
	"https://github.com/nvim-neotest/nvim-nio", -- required module
	"https://github.com/theHamsta/nvim-dap-virtual-text", -- virtual text
}, { confirm = false })

local dap = require("dap")
local dapui = require("dapui")

require("netcoredbg-macOS-arm64").setup(require("dap"))

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<F6>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", opts)
vim.keymap.set("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<F8>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
-- vim.keymap.set("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
vim.keymap.set("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
vim.keymap.set(
	"n",
	"<leader>dt",
	"<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
	{ noremap = true, silent = true, desc = "debug nearest test" }
)
vim.keymap.set("n", "<leader>du", function()
	dapui.toggle()
end, { noremap = true, silent = true, desc = "Toggle DAP UI" })
vim.keymap.set({ "n", "v" }, "<leader>dw", function()
	require("dapui").eval(nil, { enter = true })
end, { noremap = true, silent = true, desc = "Add word under cursor to Watches" })
vim.keymap.set({ "n", "v" }, "Q", function()
	require("dapui").eval()
end, {
	noremap = true,
	silent = true,
	desc = "Hover/eval a single value (opens a tiny window instead of expanding the full object) ",
})

vim.fn.sign_define("DapBreakpoint", {
	text = "⚪",
	texthl = "DapBreakpointSymbol",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapStopped", {
	text = "🔴",
	texthl = "yellow",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "⭕",
	texthl = "DapStoppedSymbol",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})

-- more minimal ui
dapui.setup({})
