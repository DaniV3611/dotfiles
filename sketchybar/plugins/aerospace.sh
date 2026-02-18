#!/bin/bash

source "$CONFIG_DIR/colors.sh"

ITEM_HEIGHT=24
PLUGIN_DIR="$CONFIG_DIR/plugins"

FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
if [ -z "$FOCUSED_WORKSPACE" ]; then
  exit 0
fi

ARGS=()

for SID in 1 2 3 4 5 6 7; do
  WINDOWS="$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)"

  if [ -n "$WINDOWS" ]; then
    APP_LIST="$(echo "$WINDOWS" | awk '!seen[$0]++ && NR<=3')"
    LABEL=""

    while IFS= read -r APP; do
      [ -z "$APP" ] && continue
      APP_ICON="$($PLUGIN_DIR/icon_map.sh "$APP")"
      LABEL="$LABEL$APP_ICON "
    done <<< "$APP_LIST"

    LABEL="${LABEL% }"

    if [ -z "$LABEL" ]; then
      LABEL="+"
    fi

    ICON_COLOR="$WS_OCCUPIED_TEXT"
    LABEL_COLOR="$WS_OCCUPIED_TEXT"
    BG_COLOR="$WS_OCCUPIED_BG"
    BORDER_COLOR="$WS_OCCUPIED_BORDER"
  else
    LABEL=""
    ICON_COLOR="$WS_EMPTY_TEXT"
    LABEL_COLOR="$WS_EMPTY_TEXT"
    BG_COLOR="$WS_EMPTY_BG"
    BORDER_COLOR="$WS_INACTIVE_BORDER"
  fi

  if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
    ICON_COLOR="$WS_ACTIVE_HIGHLIGHT"
    LABEL_COLOR="$WS_ACTIVE_HIGHLIGHT"
    BG_COLOR="$WS_ACTIVE_BG"
    BORDER_COLOR="$WS_ACTIVE_BORDER"
  fi

  ARGS+=(--set space.$SID
    drawing=on
    icon="$SID"
    icon.color=$ICON_COLOR
    icon.font="JetBrainsMono Nerd Font:Bold:16.0"
    label="$LABEL"
    label.color=$LABEL_COLOR
    label.padding_right=10
    background.drawing=on
    background.color=$BG_COLOR
    background.border_color=$BORDER_COLOR
    background.border_width=0
    background.corner_radius=$ITEM_CORNER_RADIUS
    background.height=$ITEM_HEIGHT
  )
done

sketchybar "${ARGS[@]}"
