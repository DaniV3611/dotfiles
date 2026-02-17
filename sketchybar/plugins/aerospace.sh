#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get focused workspace from aerospace
FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused 2>/dev/null)"
if [ -z "$FOCUSED_WORKSPACE" ]; then
  exit 0
fi

ARGS=()

workspace_color() {
  case "$1" in
    1) echo "0xff4ea1ff" ;; # electric blue
    2) echo "0xff66e3ff" ;; # bright cyan
    3) echo "0xff3ee6b8" ;; # mint
    4) echo "0xff8bf56a" ;; # lime green
    5) echo "0xff7dcfff" ;; # sky blue
    6) echo "0xff7aa2f7" ;; # tokyo blue
    7) echo "0xff5eead4" ;; # aqua
    8) echo "0xff9ece6a" ;; # green
    9) echo "0xff93c5fd" ;; # soft blue
    *) echo "$ACCENT" ;;
  esac
}

for SID in 1 2 3 4 5 6 7 8 9; do
  WS_COLOR="$(workspace_color "$SID")"
  WS_RGB="${WS_COLOR#0xff}"
  WS_ICON_INACTIVE="0xb0${WS_RGB}"
  WS_BG_ACTIVE="$ITEM_BG"
  WS_BG_INACTIVE="$ITEM_BG"
  WS_BORDER_ACTIVE="0xd0${WS_RGB}"
  WS_BORDER_INACTIVE="0x80${WS_RGB}"

  # Get list of windows in this workspace
  WINDOWS="$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)"

  # Build app list label
  if [ -n "$WINDOWS" ]; then
    APP_LIST=$(echo "$WINDOWS" | sort -u | tr '\n' '|' | sed 's/|$//; s/|/ | /g')
    LABEL="$APP_LIST"
  else
    LABEL=""
  fi

  if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
    # Active workspace: per-space color accent
    ARGS+=(--set space.$SID
      drawing=on
      icon="$SID"
      icon.color=$WS_COLOR
      icon.font="Hack Nerd Font:Bold:14.0"
      label="$LABEL"
      label.color=$ACTIVE_WS_LABEL
      background.drawing=on
      background.color=$WS_BG_ACTIVE
      background.border_color=$WS_BORDER_ACTIVE
      background.border_width=1
      background.corner_radius=$ITEM_CORNER_RADIUS
      background.height=28
    )
  elif [ -n "$LABEL" ]; then
    # Inactive workspace with windows: dimmed per-space color
    ARGS+=(--set space.$SID
      drawing=on
      icon="$SID"
      icon.color=$WS_ICON_INACTIVE
      icon.font="Hack Nerd Font:Bold:14.0"
      label="$LABEL"
      label.color=$INACTIVE_WS_LABEL
      background.drawing=on
      background.color=$WS_BG_INACTIVE
      background.border_color=$WS_BORDER_INACTIVE
      background.border_width=1
      background.corner_radius=$ITEM_CORNER_RADIUS
      background.height=28
    )
  else
    # Empty workspace: hidden
    ARGS+=(--set space.$SID drawing=off)
  fi
done

sketchybar "${ARGS[@]}"
