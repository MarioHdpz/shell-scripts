#!/bin/bash

xrandr --newmode "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync
xrandr --addmode eDP-1 1920x1080R
xrandr --addmode HDMI-1-1 1920x1080R
xrandr --newmode "1280x720_60.00"   74.50  1280 1344 1472 1664  720 723 728 748 -hsync +vsync
xrandr --addmode eDP-1 1280x720_60.00
xrandr --addmode HDMI-1-1 1280x720_60.00
