return { {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "BufReadPost",
	opts = {
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<C-y>", -- handled by nvim-cmp / blink.cmp
				next = "<D-]>",
				prev = "<D-[>",
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
} }
