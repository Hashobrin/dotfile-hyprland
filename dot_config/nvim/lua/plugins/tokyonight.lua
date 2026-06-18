return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        -- 非アクティブウィンドウを暗くする (WezTermのinactive_pane_hsbと同じ効果)
        hl.NormalNC = { bg = "#0f1020", fg = "#565f89" }
        -- 分割線をWezTermのsplit色に合わせる
        hl.WinSeparator = { fg = "#7aa2f7" }
      end,
    },
  },
}
