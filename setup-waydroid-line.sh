#!/bin/bash
# Waydroid + LINE setup script
# Tested on Arch Linux + Hyprland with NVIDIA+AMD iGPU dual GPU

set -e

echo "=== Waydroid + LINE セットアップ ==="

# 1. Waydroid インストール
if ! command -v waydroid &>/dev/null; then
    echo "[1/5] Waydroid をインストール中..."
    yay -S --noconfirm waydroid
else
    echo "[1/5] Waydroid は既にインストール済み"
fi

# 2. Waydroid 初期化（未初期化の場合のみ）
if [ ! -f /var/lib/waydroid/images/system.img ]; then
    echo "[2/5] Waydroid を初期化中（数分かかります）..."
    sudo waydroid init
else
    echo "[2/5] Waydroid は既に初期化済み"
fi

# 3. systemd サービス有効化
echo "[3/5] Waydroid サービスを有効化中..."
sudo systemctl enable --now waydroid-container

# 4. ARM 翻訳レイヤー（libndk）インストール
if ! command -v waydroid-extras &>/dev/null; then
    yay -S --noconfirm waydroid-script
fi

echo "[4/5] ARM 翻訳レイヤー（libndk）をインストール中..."
sudo waydroid-extras install libndk || echo "libndk インストール失敗（既に入っているか、手動でインストールしてください）"

# 5. LINE APK インストール
echo "[5/5] LINE APK インストール..."
echo ""
echo "LINE APK を以下からダウンロードしてください:"
echo "https://www.apkmirror.com/apk/naver-corporation/line/"
echo "→ ALL VARIANTS → arm64-v8a + nodpi の APK"
echo ""
echo "ダウンロード後、以下を実行:"
echo ""
echo "  # Waydroid セッション起動"
echo "  WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/\$(id -u) waydroid session start &"
echo "  sleep 8"
echo ""
echo "  # ADB でインストール"
echo "  adb connect 192.168.240.112"
echo "  adb install ~/Downloads/line.apk"
echo ""
echo "  # LINE 起動"
echo "  waydroid app launch jp.naver.line.android"
echo ""
echo "=== 注意 ==="
echo "GPU 構成が異なる場合、~/.config/hypr/custom/env.conf の"
echo "AQ_DRM_DEVICES の card0/card1 を調整してください。"
echo "(AMD iGPU を先に指定する必要があります)"
