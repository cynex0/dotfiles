#!/bin/bash
#   ____ _ _       _     _     _    
#  / ___| (_)_ __ | |__ (_)___| |_  
# | |   | | | '_ \| '_ \| / __| __| 
# | |___| | | |_) | | | | \__ \ |_  
#  \____|_|_| .__/|_| |_|_|___/\__| 
#           |_|                     
#  

case $1 in
    d) cliphist list | wofi -d -c | cliphist delete
       ;;

    w) if [ `echo -e "Clear\nCancel" | wofi --dmenu ` == "Clear" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | wofi -d | cliphist decode | wl-copy
       ;;
esac
