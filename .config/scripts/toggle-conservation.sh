#!/bin/bash

# Path to the conservation mode file
CONSERVATION_MODE_FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

# Check if the conservation mode file exists
if [[ ! -f "$CONSERVATION_MODE_FILE" ]]; then
    echo "{\"text\": \"Error\", \"class\": \"error\"}"
    exit 1
fi

# Get the current mode (1 = conservation, 0 = full charge)
MODE=$(cat "$CONSERVATION_MODE_FILE")

# Toggle mode if the script is run with a toggle argument
if [[ "$1" == "toggle" ]]; then
    if [[ "$MODE" == "1" ]]; then
        if pkexec bash -c "echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"; then
            MODE="0"
            pkill -RTMIN+13 waybar
        fi  
    else
        if pkexec bash -c "echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"; then
            MODE="1"
            pkill -RTMIN+13 waybar
        fi
    fi
fi

# Determine the text and icon based on the mode
if [[ "$MODE" == "1" ]]; then
    ICON="󰌪 "
    TEXT="Conservation mode"
    CLASS="conservation"
else
    ICON="󰞕 "
    TEXT="Full charge"
    CLASS="full"
fi

# Output JSON for Waybar
echo "{\"text\": \"$ICON \", \"alt\": \"$TEXT\", \"class\": \"$CLASS\",\"percentage\": \"$((($MODE^1) * 100))\"}"

