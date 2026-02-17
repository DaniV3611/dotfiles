#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [1-9]|[1-9][0-9]|100) COLOR=$CYAN ;;
    0)                     COLOR=$RED ;;
    *)                     COLOR=$SUBTLE ;;
  esac

  sketchybar --set "$NAME" icon="VOL" icon.color="$COLOR" label="${VOLUME}%"
fi
