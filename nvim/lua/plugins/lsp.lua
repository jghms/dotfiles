return { {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')

		-- Enable LSP servers here
		lspconfig.lua_ls.setup({
			capabilities =
			    require('cmp_nvim_lsp').default_capabilities(),
			{
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

		lspconfig.gopls.setup({})
		lspconfig.templ.setup({})
		lspconfig.ts_ls.setup({})
		lspconfig.rust_analyzer.setup({})
	end,
} }
