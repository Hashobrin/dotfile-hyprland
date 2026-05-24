-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ" })
vim.keymap.del("n", "L")
vim.keymap.del("n", "H")
vim.keymap.set("n", "D", "<cmd>bprevious<cr>", { desc = "前のバッファへ" })
vim.keymap.set("n", "N", "<cmd>bnext<cr>", { desc = "次のバッファへ" })
vim.keymap.set("n", "<C-t>", "<C-w>j", { desc = "下のウィンドウへ" })
vim.keymap.set("n", "<C-n>", "<C-w>k", { desc = "上のウィンドウへ" })
vim.keymap.set("n", "<C-s>", "<C-w>l", { desc = "右のウィンドウへ" })
