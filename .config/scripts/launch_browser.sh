#!/bin/bash

BROWSER="zen"
BROWSER_CLASS="zen"
SLEEP_TIME=0.2
ACTIVE_ONLY=false
BROWSER_ARGS=()

for arg in "$@"; do
  case "$arg" in
  --sleep=*)
    SLEEP_TIME="${arg#--sleep=}"
    ;;
  --active-only)
    ACTIVE_ONLY=true
    ;;
  *)
    BROWSER_ARGS+=("$arg")
    ;;
  esac
done

if [[ "$ACTIVE_ONLY" = true ]]; then
  active_class=$(hyprctl activewindow -j 2>/dev/null | jq -r .class)
  if [[ "$active_class" != "$BROWSER_CLASS" ]]; then
    exit 0
  fi
fi

"$BROWSER" "${BROWSER_ARGS[@]}" &

sleep "$SLEEP_TIME"

browser_address=$(hyprctl clients -j 2>/dev/null | jq -r ".[] | select(.class == \"${BROWSER_CLASS}\").address" | tail -1)

if [ -n "$browser_address" ]; then
  hyprctl dispatch settiled address:$browser_address
fi
