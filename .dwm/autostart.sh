#! /bin/bash
export AWT_TOOLKIT=MToolkit &
sudo ntpd -qg &
xmodmap ~/.xmodmaprc &
#xrandr -s 1366x768 &
light-locker &
picom -cCGb -l0 -t0 -r0 -o.00 &
xclip &
nitrogen --restore &
/usr/bin/dunst &
blueman-tray &
export TERMINAL=st &
dwmblocks &
gpg-agent --daemon &
blueman-applet &
