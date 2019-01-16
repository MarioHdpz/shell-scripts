#!/bin/sh
device_mac='30:21:67:19:4C:39'
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` off
sleep 2 
echo "disconnect $device_mac\n quit"|bluetoothctl
sleep 5
echo "connect $device_mac\n quit"|bluetoothctl
sleep 8
pacmd set-card-profile `pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}'` a2dp_sink
