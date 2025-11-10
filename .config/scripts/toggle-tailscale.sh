#!/bin/bash

if tailscale status >/dev/null 2>&1; then
   UP=1
else
   UP=0
fi

# disable VPN if connected
PIA_STATE=$(/usr/local/sbin/piactl get connectionstate)

# Toggle mode if the script is run with a toggle argument
if [[ "$1" == "toggle" ]]; then
   if [[ "$UP" == "1" ]]; then
      tailscale down
      UP="0"
      pkill -RTMIN+15 waybar

   else
      case "$PIA_STATE" in
         Connected|Connecting)
            /usr/local/sbin/piactl disconnect
            pkill -RTMIN+13 waybar # notify PIA button
            sleep 0.5
            ;;
      esac

      tailscale up
      UP="1"
      pkill -RTMIN+15 waybar # notify tailscale button
   fi
fi

# Determine the text and icon based on the mode
if [[ "$UP" == "1" ]]; then
   ICON="󰒍"
   TEXT="Up"
   CLASS="up"
else
   ICON="󰒎"
   TEXT="Down"
   CLASS="down"
fi

# Output JSON for Waybar
echo "{\"text\": \"$ICON \", \"alt\": \"$TEXT\", \"class\": \"$CLASS\"}"

