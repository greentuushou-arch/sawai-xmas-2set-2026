#!/bin/sh
# 使い方: sh export.sh  (banner/ で実行) → 1600x900 / 1600x311 / 1200x1200 の PNG と JPG
C="/c/Program Files/Google/Chrome/Application/chrome.exe"
D=$(cd "$(dirname "$0")" && pwd -W)
for spec in 900:1600:900 311:1600:311 1200:1200:1200; do
  s=${spec%%:*}; rest=${spec#*:}; w=${rest%%:*}; h=${rest#*:}
  "$C" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --virtual-time-budget=5000 \
    --window-size=$w,$h --screenshot="$D/banner-${w}x$h.png" "file:///$D/banner.html?s=$s" 2>/dev/null
  python -c "from PIL import Image;Image.open(r'$D/banner-${w}x$h.png').convert('RGB').save(r'$D/banner-${w}x$h.jpg',quality=92)"
done
