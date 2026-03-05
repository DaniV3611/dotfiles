#!/bin/bash

source "$CONFIG_DIR/colors.sh"

ITEM_HEIGHT=24
WORKSPACES=(1 2 3 4 5 6 7)
STATE_DIR="${TMPDIR:-/tmp}aerospace-sketchybar"
LAST_FOCUSED_FILE="$STATE_DIR/last-focused-workspace"

app_icon() {
  case "$1" in
    "Finder") printf '%s' "󰀶" ;;
    "Calendar"|"Apple Calendar") printf '%s' "󰃭" ;;
    "Safari") printf '%s' "󰀹" ;;
    "Google Chrome") printf '%s' "󰊯" ;;
    "Firefox") printf '%s' "󰈹" ;;
    "Brave Browser"|"Brave") printf '%s' "󰖟" ;;
    "Zen"|"zen") printf '%s' "󰈹" ;;
    "Arc") printf '%s' "󰞍" ;;
    "Terminal"|"iTerm2") printf '%s' "󰆍" ;;
    "Ghostty") printf '%s' "󰊠" ;;
    "Warp") printf '%s' "󰆍" ;;
    "Visual Studio Code"|"Code") printf '%s' "󰨞" ;;
    "Cursor") printf '%s' "󰨞" ;;
    "DBeaver") printf '%s' "󰆼" ;;
    "Notion") printf '%s' "" ;;
    *"WhatsApp"*) printf '%s' "󰖣" ;;
    "Figma") printf '%s' "󰟬" ;;
    "Discord") printf '%s' "󰙯" ;;
    "Slack") printf '%s' "󰒱" ;;
    "Spotify") printf '%s' "󰓇" ;;
    "ChatGPT") printf '%s' "󰭻" ;;
    "Unity") printf '%s' "󰚯" ;;
    "Unity Hub") printf '%s' "" ;;
    "Preview") printf '%s' "󰈙" ;;
    *) printf '%s' "󰋜" ;;
  esac
}

FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
if [ -z "$FOCUSED_WORKSPACE" ]; then
  exit 0
fi

mkdir -p "$STATE_DIR"

PREVIOUS_FOCUSED=""
if [ -r "$LAST_FOCUSED_FILE" ]; then
  PREVIOUS_FOCUSED="$(<"$LAST_FOCUSED_FILE")"
fi

TARGET_WORKSPACES=()
if [ -n "$PREVIOUS_FOCUSED" ] && [ "$PREVIOUS_FOCUSED" != "$FOCUSED_WORKSPACE" ]; then
  TARGET_WORKSPACES+=("$FOCUSED_WORKSPACE")
  TARGET_WORKSPACES+=("$PREVIOUS_FOCUSED")
else
  TARGET_WORKSPACES=("${WORKSPACES[@]}")
fi

printf '%s\n' "$FOCUSED_WORKSPACE" > "$LAST_FOCUSED_FILE"

ARGS=()

for SID in "${TARGET_WORKSPACES[@]}"; do
  WINDOWS="$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)"

  if [ -n "$WINDOWS" ]; then
    LABEL=""
    SEEN_APPS="|"
    APP_COUNT=0

    while IFS= read -r APP; do
      [ -z "$APP" ] && continue

      case "$SEEN_APPS" in
        *"|$APP|"*) continue ;;
      esac

      SEEN_APPS="${SEEN_APPS}${APP}|"
      APP_ICON="$(app_icon "$APP")"
      LABEL="$LABEL$APP_ICON "
      APP_COUNT=$((APP_COUNT + 1))

      [ "$APP_COUNT" -ge 3 ] && break
    done <<< "$WINDOWS"

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
