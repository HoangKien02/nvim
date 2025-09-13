-- bootstrap lazy.nvim, LazyVim and your plugins
vim.keymap.set('n', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Đặt Space làm leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy") -- Tắt chức năng mặc định của Space trong Normal mode
