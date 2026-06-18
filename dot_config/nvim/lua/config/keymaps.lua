-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "L")
vim.keymap.del("n", "H")
vim.keymap.set("n", "D", "<cmd>bprevious<cr>", { desc = "前のバッファへ" })
vim.keymap.set("n", "N", "<cmd>bnext<cr>", { desc = "次のバッファへ" })
vim.keymap.set("n", "<C-d>", "<C-w>h", { desc = "左のウィンドウへ" })
vim.keymap.set("n", "<C-h>", "<C-w>j", { desc = "下のウィンドウへ" })
vim.keymap.set("n", "<C-t>", "<C-w>k", { desc = "上のウィンドウへ" })
vim.keymap.set("n", "<C-n>", "<C-w>l", { desc = "右のウィンドウへ" })

-- Dvorakカーソル移動 (j/k → h/t)
vim.keymap.set({ "n", "x" }, "h", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "下へ移動" })
vim.keymap.set({ "n", "x" }, "t", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "上へ移動" })

-- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "ターミナルモードを終了" })

vim.keymap.set("n", "<leader>t", function()
  vim.cmd("botright 15split | terminal")
end, { noremap = true })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
