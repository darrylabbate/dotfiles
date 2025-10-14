#!/bin/bash

# Check if caffeinate is running
if pgrep -f "caffeinate -d" > /dev/null; then
    echo "􀸙 | font=SF-Pro-Display-Light"
    echo "---"
    echo "Decaffeinate | bash='$0' param1=off terminal=false refresh=true"
else
    echo "􀸘 | font=SF-Pro-Display-Light"
    echo "---"
    echo "Caffeinate | bash='$0' param1=on terminal=false refresh=true"
fi

# Handle toggle actions
if [ "$1" = "on" ]; then
    nohup caffeinate -d > /dev/null 2>&1 &
elif [ "$1" = "off" ]; then
    pkill -f "caffeinate -d"
fi
