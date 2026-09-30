#!/data/data/com.termux/files/usr/bin/bash
# Audacity on Android · 一键安装脚本
# 用法：在 Termux 里运行  bash install.sh
# 仓库：github.com/lijiamin961-ship-it/audacity-on-android

set -e
echo "══════════════════════════════════════"
echo "  Audacity on Android · 一键安装"
echo "══════════════════════════════════════"
echo ""
echo "[1/4] 申请存储权限（弹窗请点「允许」）"
termux-setup-storage

echo ""
echo "[2/4] 更新 Termux 软件源（约 1-3 分钟）"
pkg update -y || true
pkg upgrade -y || true

echo ""
echo "[3/4] 安装 Ubuntu 子系统（约 200MB，5-10 分钟）"
pkg install proot-distro -y
proot-distro install ubuntu

echo ""
echo "[4/4] 在 Ubuntu 里安装 Audacity + ffmpeg（约 200MB，5-10 分钟）"
proot-distro login ubuntu -- bash -c "apt update && apt install -y audacity ffmpeg"

# 布置 move.sh（导出音频后，把文件搬回安卓「下载」）
cat > ~/move.sh << 'EOF'
#!/bin/bash
# 把家目录里的音频搬到安卓「下载」文件夹
cp -u ~/*.mp3 ~/storage/downloads/ 2>/dev/null
cp -u ~/*.wav ~/storage/downloads/ 2>/dev/null
echo "搬完！「下载」文件夹里最近的文件："
ls -lt ~/storage/downloads 2>/dev/null | head -10
EOF
chmod +x ~/move.sh

echo ""
echo "══════════════════════════════════════"
echo "  安装完成！"
echo "══════════════════════════════════════"
echo ""
echo "以后每次使用，只需两步："
echo "  1. 进入 Ubuntu：  proot-distro login ubuntu"
echo "  2. 启动软件：    audacity"
echo ""
echo "导出音频后，在同一个 Ubuntu 窗口里跑："
echo "  bash ~/move.sh"
echo "文件就会出现在安卓「下载」文件夹里。"
