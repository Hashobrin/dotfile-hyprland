-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.colorcolumn = "80"

-- ノーマルモードに戻ったときにfcitx5を英数モードに切り替える
-- JPキーボードでShift+D/H/T/Nなどのコマンドが日本語入力に横取りされるのを防ぐ
local function deactivate_ime()
  vim.fn.system("fcitx5-remote -c")
end

-- インサート/ビジュアル等 → ノーマルモードへの遷移時
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:n",
  callback = deactivate_ime,
})

-- ターミナルモード（:terminal）→ ノーマルモードへの遷移時（Ctrl+\ Ctrl+N）
vim.api.nvim_create_autocmd("TermLeave", {
  callback = deactivate_ime,
})
