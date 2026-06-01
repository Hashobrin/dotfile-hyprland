#!/bin/bash
# LINE Windows VM セットアップスクリプト
# KVM/QEMU で Windows 11 VM を作成し LINE PC 版を動かす
# スマホと同時ログイン可能（PC 版は別枠）
#
# 前提：Windows 11 ISO を ~/Downloads/ に置いておくこと
# Microsoft 公式: microsoft.com/ja-jp/software-download/windows11

set -e

echo "=== LINE Windows VM セットアップ ==="

# 1. パッケージインストール
echo "[1/5] パッケージをインストール中..."
sudo pacman -S --needed --noconfirm virt-manager qemu-desktop libvirt dnsmasq swtpm
yay -S --needed --noconfirm virtio-win

# 2. libvirtd 有効化
echo "[2/5] libvirtd を有効化中..."
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt "$(whoami)"

# 3. default ネットワーク起動
echo "[3/5] 仮想ネットワークを設定中..."
virsh --connect qemu:///system net-start default 2>/dev/null || true
virsh --connect qemu:///system net-autostart default

# 4. Windows ISO を libvirt の領域にコピー
echo "[4/5] Windows ISO を準備中..."
WIN_ISO=$(find ~/Downloads -name "Win11*.iso" | head -1)
if [ -z "$WIN_ISO" ]; then
    echo "ERROR: ~/Downloads に Windows 11 ISO が見つかりません"
    echo "microsoft.com/ja-jp/software-download/windows11 からダウンロードしてください"
    exit 1
fi
sudo cp -n "$WIN_ISO" /var/lib/libvirt/images/windows11.iso
echo "ISO: $WIN_ISO → /var/lib/libvirt/images/windows11.iso"

# 5. VM 作成（既存の場合はスキップ）
echo "[5/5] VM を作成中..."
if virsh --connect qemu:///system dominfo LINE-Windows &>/dev/null; then
    echo "LINE-Windows VM は既に存在します"
else
    virt-install \
        --connect qemu:///system \
        --name LINE-Windows \
        --ram 4096 \
        --vcpus 2 \
        --os-variant win11 \
        --disk path=/var/lib/libvirt/images/LINE-Windows.qcow2,size=64,format=qcow2,bus=virtio \
        --cdrom /var/lib/libvirt/images/windows11.iso \
        --disk /var/lib/libvirt/images/virtio-win.iso,device=cdrom \
        --network network=default,model=virtio \
        --graphics spice \
        --video virtio \
        --boot uefi \
        --tpm backend.type=emulator,backend.version=2.0,model=tpm-crb \
        --features smm.state=on \
        --noautoconsole
fi

echo ""
echo "=== VM 作成完了 ==="
echo ""
echo "次の手順（手動）:"
echo "  1. virt-manager を起動して LINE-Windows をダブルクリック"
echo "  2. Windows インストール中にストレージが見つからない場合:"
echo "     「ドライバーのロード」→ virtio-win CD → amd64/w11 → VirtIO SCSI"
echo "  3. ネットワーク画面で「ドライバーのインストール」:"
echo "     virtio-win CD → NetKVM/w11/amd64"
echo "  4. Windows インストール完了後:"
echo "     virtio-win CD の virtio-win-gt-x64.msi を実行（全ドライバ一括）"
echo "  5. LINE for Windows をインストール → QR コードでスマホからログイン"
echo ""
echo "ランチャーから起動: アプリ一覧で「LINE」を検索"
