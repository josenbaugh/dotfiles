#! /bin/bash
xmodmap ~/.xmodmaprc
xrandr -s 1366x768 &
light-locker &
picom &
xclip &
nitrogen --restore &
/usr/bin/dunst &
blueman-tray &
export TERMINAL=st &
dwmblocks &
