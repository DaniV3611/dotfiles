#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CPU_USAGE=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print int($3 + $5)}')

if [ "$CPU_USAGE" -gt 80 ]; then
  COLOR=$RED
elif [ "$CPU_USAGE" -gt 50 ]; then
  COLOR=$ORANGE
else
  COLOR=$CYAN
fi

sketchybar --set "$NAME" icon="CPU" icon.color="$COLOR" label="${CPU_USAGE}%"
