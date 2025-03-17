-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set("n", "<leader>b", ":Telescope file_browser<CR>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", function ()
	vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
end)

-- maps : to ; to make the Shift press unnecessary
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')

-- reload the neovim config
vim.keymap.set('n', '<leader>vv', ':so ~/.config/nvim/init.lua')
