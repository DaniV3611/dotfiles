#!/bin/bash

case "$1" in
  # ===== System / File =====
  "Finder") echo "󰀶" ;;
  "Calendar"|"Apple Calendar") echo "󰃭" ;;

  # ===== Browsers =====
  "Safari") echo "󰀹" ;;
  "Google Chrome") echo "󰊯" ;;
  "Firefox") echo "󰈹" ;;
  "Brave Browser"|"Brave") echo "󰖟" ;;
  "Zen"|"zen") echo "󰈹" ;;   # genérico tipo zen / circle
  "Arc") echo "󰞍" ;;

  # ===== Terminals =====
  "Terminal"|"iTerm2") echo "󰆍" ;;
  "Ghostty") echo "󰊠" ;;
  "Warp") echo "󰆍" ;;   # no icono oficial en Nerd Fonts, terminal fallback

  # ===== Dev / IDE =====
  "Visual Studio Code"|"Code") echo "󰨞" ;;
  "Cursor") echo "󰨞" ;;   # basado en VS Code
  "DBeaver") echo "󰆼" ;;  # database icon

  # ===== Apps =====
  "Notion") echo "" ;;
  *"WhatsApp"*) echo "󰖣" ;;
  "Figma") echo "󰟬" ;;
  "Discord") echo "󰙯" ;;
  "Slack") echo "󰒱" ;;
  "Spotify") echo "󰓇" ;;
  "ChatGPT") echo "󰭻" ;;
  "Unity") echo "󰚯" ;;

  # ===== Fallback =====
  *) echo "󰋜" ;;
esac
