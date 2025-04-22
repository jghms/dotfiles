return {
	-- nvim-cmp and its dependencies
	{
		'hrsh7th/nvim-cmp',               -- The completion plugin
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',         -- LSP completions
			'hrsh7th/cmp-buffer',           -- Buffer completions
			'hrsh7th/cmp-path',             -- File path completions
			'hrsh7th/cmp-cmdline',          -- Command-line completions
			'saadparwaiz1/cmp_luasnip',     -- Snippet completions
			'L3MON4D3/LuaSnip',             -- Snippet engine
			'rafamadriz/friendly-snippets', -- Predefined snippets
		},
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			-- Load friendly snippets
			require('luasnip.loaders.from_vscode').lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-y>'] = cmp.config.disable, -- Disable default <C-y> behavior
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer' },
					{ name = 'path' },
				}),
			})

			-- Command-line completion
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})

			-- Search mode completion
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})
		end,
	},
}
