return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		opts = {
			defaults = {
				path_display = { shorten = 3 },
				prompt_prefix = "> ",
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--exclude", "node_modules" },
				file_ignore_patterns = { "node_modules", ".git/", ".hg/", ".svn/", "__pycache__" },
			},
			extensions_list = { "fzf", "terms", "themes", "file_browser" },
		}
	},
}
