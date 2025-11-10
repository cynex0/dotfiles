#!/bin/bash

STATE=$(/usr/local/sbin/piactl get connectionstate)
CLASS="$(echo $STATE | tr '[:upper:]' '[:lower:]')"

if tailscale status >/dev/null 2>&1; then
   TAILSCALE_UP=1
else
   TAILSCALE_UP=0
fi

case "$STATE" in
   Connected)
      if [[ "$1" == "toggle" ]]; then
         /usr/local/sbin/piactl disconnect
         exit 0
      else
         ICON="󰌾"
      fi
      ;;
   Disconnected)
      if [[ "$1" == "toggle" ]]; then
         if [[ "$TAILSCALE_UP" == "1" ]]; then
            tailscale down
            pkill -RTMIN+15 waybar # notify Tailscale button
            sleep 0.5
         fi
         /usr/local/sbin/piactl connect
         exit 0
      else
         ICON="󰿇"
      fi
      ;;
   Connecting|Disconnecting|Reconnecting)
      ICON="󰇘"
      ;;
   *)
      ICON="󱗒"
      ;;
esac

# Output JSON for Waybar
echo "{\"text\": \"$ICON \", \"alt\": \"$STATE\", \"class\": \"$CLASS\"}"

