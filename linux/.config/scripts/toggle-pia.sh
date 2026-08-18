#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

STATE=$($SCRIPT_DIR/helpers/get-pia-status.sh)
CLASS="$(echo $STATE | tr '[:upper:]' '[:lower:]')"

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
         TAILSCALE_UP=$($SCRIPT_DIR/helpers/get-tailscale-status.sh)
         if [[ "$TAILSCALE_UP" == "1" ]]; then
            tailscale down
            pkill -RTMIN+15 waybar # notify Tailscale button
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

