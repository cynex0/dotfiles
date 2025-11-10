#!/bin/bash

# TO FUTURE SELF:
#  this requires ` sudo tailscale set --operator=$USER ` to run without sudo

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

UP=$($SCRIPT_DIR/helpers/get-tailscale-status.sh)
PIA_STATE=$($SCRIPT_DIR/helpers/get-pia-status.sh)

# Toggle mode if the script is run with a toggle argument
if [[ "$1" == "toggle" ]]; then
   if [[ "$UP" == "1" ]]; then
      tailscale down
      UP="0"
      pkill -RTMIN+15 waybar

   else
      # disable VPN if connected
      case "$PIA_STATE" in
         Connected|Connecting)
            /usr/local/sbin/piactl disconnect
            pkill -RTMIN+13 waybar # notify PIA button
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

