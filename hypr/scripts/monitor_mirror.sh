#!/usr/bin/zsh

# 自分のノートPCのディスプレイ名に書き換えてください
LAPTOP_DISPLAY="eDP-1"

handle() {
  case $1 in
    monitoradded>>*)
      # 新しく接続されたディスプレイ名を取得
      EXTERNAL_DISPLAY=$(echo $1 | cut -d'>' -f3)

      # ノートPCのディスプレイを有効にし、
      # 新しいディスプレイをそのミラーとして設定する
      hyprctl --batch "\
              keyword monitor $EXTERNAL_DISPLAY,preferred,0x0,1;\
              keyword monitor $LAPTOP_DISPLAY,disable"
    monitoremoved>>*)
      # ディスプレイが切断されたら、ノートPCのディスプレイ設定を再度有効にする
      # これでミラーリングが解除され、単一表示に戻る
      hyprctl keyword monitor "$LAPTOP_DISPLAY,preferred,auto,1"
      ;;
  esac
}

# Hyprlandのイベントを監視
socat - "UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do
  handle "$line"
done