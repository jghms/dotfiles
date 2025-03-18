return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		opt = {
			defaults = {
				path_display = { shorten = 3 },
				prompt_prefix = "> ",
			},
			extensions_list = { "fzf", "terms", "themes", "file_browser" },
		}
	},
}
