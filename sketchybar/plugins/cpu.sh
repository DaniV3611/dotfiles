#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CPU_USAGE=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print int($3 + $5)}')

if [ "$CPU_USAGE" -gt 80 ]; then
  COLOR=$RED
  ICON="󰓅"
elif [ "$CPU_USAGE" -gt 50 ]; then
  COLOR=$ORANGE
  ICON="󰾆"
else
  COLOR=$CYAN
  ICON="󰍛"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${CPU_USAGE}%"
