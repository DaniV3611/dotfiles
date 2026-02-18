#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "mouse.clicked" ]; then
  MUTED_NOW="$(osascript -e 'output muted of (get volume settings)' 2>/dev/null | tr -d '\r')"
  if [ "$MUTED_NOW" = "true" ]; then
    osascript -e 'set volume output muted false' >/dev/null 2>&1
  else
    osascript -e 'set volume output muted true' >/dev/null 2>&1
  fi
  sleep 0.08
fi

if [ -n "$INFO" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)"
fi

MUTED="$(osascript -e 'output muted of (get volume settings)' 2>/dev/null | tr -d '\r')"

case "$VOLUME" in
  ''|*[!0-9]*)
    VOLUME=0
    ;;
esac

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="󰖁"
  COLOR=$RED
  LABEL="mute"
elif [ "$VOLUME" -lt 35 ]; then
  ICON="󰕿"
  COLOR=$CYAN
  LABEL="${VOLUME}%"
elif [ "$VOLUME" -lt 70 ]; then
  ICON="󰖀"
  COLOR=$CYAN
  LABEL="${VOLUME}%"
else
  ICON="󰕾"
  COLOR=$BLUE
  LABEL="${VOLUME}%"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="$LABEL"
