#!/bin/bash

source "$CONFIG_DIR/colors.sh"

MAX_LEN=34

PLAYER=""

if pgrep -x "Spotify" >/dev/null 2>&1; then
  PLAYER="Spotify"
elif pgrep -x "Music" >/dev/null 2>&1; then
  PLAYER="Music"
fi

if [ "$SENDER" = "mouse.clicked" ] && [ -n "$PLAYER" ]; then
  osascript -e "tell application \"$PLAYER\" to playpause" >/dev/null 2>&1
  sleep 0.1
fi

if [ -z "$PLAYER" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

STATE="$(osascript -e "tell application \"$PLAYER\" to player state as string" 2>/dev/null)"
TRACK="$(osascript -e "tell application \"$PLAYER\" to if player state is not stopped then name of current track" 2>/dev/null)"
ARTIST="$(osascript -e "tell application \"$PLAYER\" to if player state is not stopped then artist of current track" 2>/dev/null)"

if [ "$STATE" = "stopped" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$STATE" = "playing" ]; then
  ICON="󰏤"
  COLOR="$GREEN"
else
  ICON="󰐊"
  COLOR="$ACCENT"
fi

if [ -n "$TRACK" ] && [ -n "$ARTIST" ]; then
  LABEL="$TRACK - $ARTIST"
elif [ -n "$TRACK" ]; then
  LABEL="$TRACK"
else
  LABEL="$PLAYER"
fi

if [ "${#LABEL}" -gt "$MAX_LEN" ]; then
  LABEL="${LABEL:0:$((MAX_LEN - 3))}..."
fi

sketchybar --set "$NAME" drawing=on icon="$ICON" icon.color="$COLOR" label="$LABEL" label.drawing=on
