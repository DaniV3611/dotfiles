#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get focused workspace (prefer event payload when available)
FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
if [ -z "$FOCUSED_WORKSPACE" ]; then
  exit 0
fi

ARGS=()

for SID in 1 2 3 4 5 6 7; do
  # Get list of windows in this workspace
  WINDOWS="$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)"

  # Build app list label for occupied workspaces
  if [ -n "$WINDOWS" ]; then
    APP_LIST=$(echo "$WINDOWS" | sort -u | tr '\n' '|' | sed 's/|$//; s/|/ | /g')
    LABEL="· $APP_LIST"
    ICON_COLOR="$WS_OCCUPIED_TEXT"
    LABEL_COLOR="$WS_OCCUPIED_TEXT"
  else
    LABEL=""
    ICON_COLOR="$WS_EMPTY_TEXT"
    LABEL_COLOR="$WS_EMPTY_TEXT"
  fi

  if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
    ICON_COLOR="$WS_ACTIVE_HIGHLIGHT"
    LABEL_COLOR="$WS_ACTIVE_HIGHLIGHT"
    BORDER_COLOR="$WS_ACTIVE_HIGHLIGHT"
  else
    BORDER_COLOR="$WS_INACTIVE_BORDER"
  fi

  ARGS+=(--set space.$SID
    drawing=on
    icon="$SID"
    icon.color=$ICON_COLOR
    icon.font="Hack Nerd Font:Bold:14.0"
    label="$LABEL"
    label.color=$LABEL_COLOR
    background.drawing=on
    background.color=$ITEM_BG
    background.border_color=$BORDER_COLOR
    background.border_width=1
    background.corner_radius=$ITEM_CORNER_RADIUS
    background.height=28
  )
done

sketchybar "${ARGS[@]}"
