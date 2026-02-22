local format_buf = require("config.format")

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- Go to definition, declaration, references, type definition, implementation
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

	-- Show documentation
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

	-- Code actions & renaming
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	-- Diagnostics navigation
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

	-- Formatting
	vim.keymap.set("n", "<leader>f", format_buf, opts)
end

return { {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')

		-- Enable LSP servers here
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			}
		})

		lspconfig.tsp_server.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		})

		lspconfig.sqls.setup {
			on_attach = function (client, bufnr)
				on_attach(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
			end,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		}

		lspconfig.elixirls.setup{
			cmd = { "/opt/homebrew/bin/elixir-ls" },
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		}

		lspconfig.gleam.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		})

		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		})
		lspconfig.templ.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
		})
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
			root_markers = { "package.json" },
			single_file_support = false,
		})
		lspconfig.denols.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		})
		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = require('cmp_nvim_lsp').default_capabilities(),
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					procMacro = {
						enable = true,
					},
				},
			},
		})
	end,
} }
