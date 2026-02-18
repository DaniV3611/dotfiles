#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SSID="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I 2>/dev/null | awk -F': ' '/ SSID/{print $2}')"

if [ -z "$SSID" ]; then
  SSID="$(ipconfig getsummary en0 2>/dev/null | awk -F ' SSID : ' '/ SSID : / {print $2}')"
fi

if [ -n "$SSID" ]; then
  COLOR=$BLUE
  ICON="󰖩"
else
  COLOR=$RED
  ICON="󰖪"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"
