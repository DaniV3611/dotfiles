#!/bin/bash

PLUGIN_DIR="$CONFIG_DIR/plugins"
ICON_MAP="$PLUGIN_DIR/icon_map.sh"

if [ "$SENDER" != "front_app_switched" ]; then
  exit 0
fi

APP_NAME="${INFO:-Desktop}"
MAX_LEN=24

if [ -x "$ICON_MAP" ]; then
  APP_ICON="$($ICON_MAP "$APP_NAME")"
else
  APP_ICON="󰋜"
fi

LABEL="$APP_NAME"
if [ "${#APP_NAME}" -gt "$MAX_LEN" ]; then
  LABEL="${APP_NAME:0:$((MAX_LEN - 3))}..."
fi

BG=0xfff3b269
BORDER=0xfff8c997
FG=0xff18222d

sketchybar --animate tanh 15 --set "$NAME" \
  icon="$APP_ICON" \
  icon.color="$FG" \
  label="$LABEL" \
  label.color="$FG" \
  background.color="$BG" \
  background.border_color="$BORDER"
