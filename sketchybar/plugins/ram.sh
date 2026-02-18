#!/bin/bash

source "$CONFIG_DIR/colors.sh"

TOTAL_MEM=$(sysctl -n hw.memsize)
TOTAL_MEM_MB=$((TOTAL_MEM / 1024 / 1024))

PAGES_ACTIVE=$(vm_stat | awk '/Pages active/ {gsub(/\./,""); print $3}')
PAGES_WIRED=$(vm_stat | awk '/Pages wired/ {gsub(/\./,""); print $4}')
PAGES_COMPRESSED=$(vm_stat | awk '/Pages occupied by compressor/ {gsub(/\./,""); print $5}')
PAGE_SIZE=$(sysctl -n hw.pagesize)

USED_MEM_MB=$(( (PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED) * PAGE_SIZE / 1024 / 1024 ))
RAM_PERCENTAGE=$((USED_MEM_MB * 100 / TOTAL_MEM_MB))

if [ "$RAM_PERCENTAGE" -gt 80 ]; then
  COLOR=$RED
  ICON="󰓅"
elif [ "$RAM_PERCENTAGE" -gt 60 ]; then
  COLOR=0xffff8fc7
  ICON="󰘚"
else
  COLOR=$MAGENTA
  ICON="󰘚"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${RAM_PERCENTAGE}%"
