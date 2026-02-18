#!/bin/bash

source "$CONFIG_DIR/colors.sh"

BATT_INFO="$(pmset -g batt)"
PERCENTAGE="$(echo "$BATT_INFO" | grep -Eo "[0-9]+%" | awk 'NR==1 { gsub("%", "", $0); print; exit }')"
CHARGING="$(echo "$BATT_INFO" | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

if [[ "$CHARGING" != "" ]]; then
  COLOR=$GREEN
  ICON="󱐌"
elif [ "$PERCENTAGE" -ge 90 ]; then
  COLOR=$GREEN
  ICON=""
elif [ "$PERCENTAGE" -ge 75 ]; then
  COLOR=$GREEN
  ICON=""
elif [ "$PERCENTAGE" -ge 50 ]; then
  COLOR=$YELLOW
  ICON=""
elif [ "$PERCENTAGE" -ge 25 ]; then
  COLOR=$ORANGE
  ICON=""
else
  COLOR=$RED
  ICON=""
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
