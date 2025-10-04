#!/bin/bash

STATE=$(/usr/local/sbin/piactl get connectionstate)
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
         /usr/local/sbin/piactl connect
         exit 0
      else
         ICON="󰿇"
      fi
      ;;
   Connecting|Disconnecting)
      ICON="󰇘"
      ;;
   *)
      ICON="󱗒"
      ;;
esac

# Output JSON for Waybar
echo "{\"text\": \"$ICON \", \"alt\": \"$STATE\", \"class\": \"$CLASS\"}"

