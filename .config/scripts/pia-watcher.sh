#!/bin/bash

/usr/local/sbin/piactl monitor connectionstate | while read -r STATE; do
    pkill -RTMIN+14 waybar
done
