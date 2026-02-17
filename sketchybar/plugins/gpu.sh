#!/bin/bash

source "$CONFIG_DIR/colors.sh"

GPU_USAGE=$(ioreg -r -d 1 -w 0 -c AGXAccelerator 2>/dev/null | perl -ne 'if (/"Device Utilization %"\s*=\s*([0-9]+)/) { print "$1\n"; exit }')

if [ -z "$GPU_USAGE" ]; then
  sketchybar --set "$NAME" icon.color="$BLUE" label="N/A"
  exit 0
fi

if [ "$GPU_USAGE" -gt 80 ]; then
  COLOR=$RED
elif [ "$GPU_USAGE" -gt 50 ]; then
  COLOR=$ORANGE
else
  COLOR=$GREEN
fi

sketchybar --set "$NAME" icon.color="$COLOR" label="${GPU_USAGE}%"
