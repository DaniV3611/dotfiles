#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [ -n "$INFO" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)"
fi

case "$VOLUME" in
  ''|*[!0-9]*)
    VOLUME=0
    ;;
esac

if [ "$VOLUME" -eq 0 ]; then
  ICON="󰖁"
  COLOR=$RED
elif [ "$VOLUME" -lt 35 ]; then
  ICON="󰕿"
  COLOR=$CYAN
elif [ "$VOLUME" -lt 70 ]; then
  ICON="󰖀"
  COLOR=$CYAN
else
  ICON="󰕾"
  COLOR=$BLUE
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${VOLUME}%"
