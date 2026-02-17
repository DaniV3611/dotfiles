#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) COLOR=$GREEN ;;
  [7-8][0-9]) COLOR=$GREEN ;;
  [5-6][0-9]) COLOR=$YELLOW ;;
  [3-4][0-9]) COLOR=$ORANGE ;;
  [1-2][0-9]) COLOR=$RED ;;
  *)          COLOR=$RED ;;
esac

if [[ "$CHARGING" != "" ]]; then
  COLOR=$GREEN
  ICON="󰂄"
else
  ICON="󰁹"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
