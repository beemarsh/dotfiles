#!/bin/sh

# Don't forget to mark .xinitrc as executable, it will logout immediately after a login if using X
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap


#xrandr --auto
#xrandr --setprovideroffloadsink 1 0
#xrandr --output eDP-1 --auto --output DisplayPort-0 --auto --scale 1.5x1.5 --right-of eDP-1

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

exec i3
