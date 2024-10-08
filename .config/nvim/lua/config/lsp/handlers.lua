local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlight then
		vim.api.nvim_exec2(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			{ output = false }
		)
	end
end

local function map(buffer, mode, lhs, rhs, desc)
	vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

local function lsp_keymaps(bufnr)
	map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declartion")
	map(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Go to definition")
	map(bufnr, "n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", "Goto T[y]pe Definition")
	map(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Go to implementation")
	map(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", "Show references")

	map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
	map(bufnr, "n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show Signature Help")
	map(bufnr, "i", "<C-k>, <cmd>lua vim.lsp.buf.signature_help()<CR>", "Show Signature Help")

  -- Diagnostics keympas moved to trouble.nvim
	--[[ map(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', "Go to previous diagnostics") ]]
	--[[ map(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Go to next diagnostics") ]]

	--[[ map(bufnr, "n", "<C-o>d", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open Floating Diagnostics") ]]
	--[[ map(bufnr, "n", "<C-o>D", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Open Diagnostics List") ]]
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
	M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
