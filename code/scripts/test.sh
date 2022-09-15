#!/bin/sh

wifi_display () {
icon="📶"
offline="❌"

networkstatus="$( networkctl --lines=0 status wlan0 | grep "Online state\|WiFi" | sed "s/.*: //" | sed "s/(.*)//")"
onlinestatus=$(echo $networkstatus | cut -f1 -d" ")
ssid=$(echo $networkstatus | cut -f2 -d" ")

if [ "$onlinestatus" == "online" ]; then
    echo "$icon $ssid"
else
    echo "$icon $offline"
fi
}


echo $(wifi_display)
