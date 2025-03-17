-- remap leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

-- colorscheme
require("catppuccin")
vim.cmd.colorscheme "catppuccin-mocha"




require("config.keymap")
