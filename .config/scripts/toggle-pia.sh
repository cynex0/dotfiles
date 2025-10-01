#!/bin/bash

# Get the current mode
STATE=$(/usr/local/sbin/piactl get connectionstate)
CLASS="$(echo $STATE | tr '[:upper:]' '[:lower:]')"

# Toggle mode if the script is run with a toggle argument
case "$STATE" in
   Connected)
      if [[ "$1" == "toggle" ]]; then
         /usr/local/sbin/piactl disconnect
         pkill -RTMIN+14 waybar
         exit
      else
         ICON="󰌾"
      fi
      ;;
   Disconnected)
      if [[ "$1" == "toggle" ]]; then
         /usr/local/sbin/piactl connect
         pkill -RTMIN+14 waybar
         exit
      else
         ICON="󰿇"
      fi
      ;;
   Connecting|Disconnecting)
      ICON=""
      ( sleep 0.1; pkill -RTMIN+14 waybar ) &
      ;;
   *)
      ICON="󱗒"
      STATE="Unknown"
      ( sleep 5; pkill -RTMIN+14 waybar ) &
      ;;
esac

# Output JSON for Waybar
echo "{\"text\": \"$ICON \", \"alt\": \"$STATE\", \"class\": \"$CLASS\"}"

