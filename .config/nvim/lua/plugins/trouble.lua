return {
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<C-o>dD",
				"<cmd>Trouble diagnostics toggle preview={type = float, relative = editor, border = rounded, title = Preview, title_pos = center, position = { 0, -2 }, size = { width = 0.3, height = 0.3 }, zindex = 200,}<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<C-o>dd",
				"<cmd>lua vim.diagnostic.open_float()<CR>",
				desc = "Open Floating Diagnostics",
			},
			{
				"<C-o>dp",
				'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
				desc = "Go to previous diagnostics",
			},
			{
				"<C-o>dn",
				'<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
				desc = "Go to next diagnostics",
			},
			{
				"<C-o>D",
				"<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<C-o>ds",
				"<cmd>Trouble symbols toggle focus=true<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<C-o>dl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<C-o>dL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<C-o>dq",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
