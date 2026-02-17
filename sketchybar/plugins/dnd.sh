#!/bin/bash

source "$CONFIG_DIR/colors.sh"

DB="$HOME/Library/DoNotDisturb/DB/Assertions.json"

ACTIVE=0

MODE_STATE="$(notifyutil -g com.apple.donotdisturb.mode 2>/dev/null | awk '{print $NF}')"
USER_MODE_STATE="$(notifyutil -g com.apple.donotdisturb.user-mode 2>/dev/null | awk '{print $NF}')"

if [ -n "$MODE_STATE" ] && [ "$MODE_STATE" != "0" ]; then
  ACTIVE=1
elif [ -n "$USER_MODE_STATE" ] && [ "$USER_MODE_STATE" != "0" ]; then
  ACTIVE=1
fi

if [ "$ACTIVE" = "0" ] && [ -f "$DB" ]; then
  ACTIVE="$(python3 - <<'PY'
import json
import os

path = os.path.expanduser('~/Library/DoNotDisturb/DB/Assertions.json')

try:
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    records = ((data.get('data') or [{}])[0].get('storeAssertionRecords') or [])
    print('1' if records else '0')
except Exception:
    print('0')
PY
  )"
fi

if [ "$ACTIVE" = "1" ]; then
  sketchybar --set "$NAME" drawing=on icon="DND" icon.color="$RED" label="ON" label.color="$RIGHT_PRIMARY_TEXT"
else
  sketchybar --set "$NAME" drawing=off
fi
