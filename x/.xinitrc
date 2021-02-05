#!/bin/sh
X_PATH=$HOME/dotfiles/x
userresources=$X_PATH/.Xresources
usermodmap=$X_PATH/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

for f in $X_PATH/?*.sh ; do
  [ -x "$f" ] && . "$f"
done
unset f

clipmenud &!

dunst &!

setxkbmap -option caps:escape

xbindkeys & # binding keys

xinput set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Accel Speed" 0.8
xinput set-prop "SYNA2393:00 06CB:7A13 Touchpad" "libinput Natural Scrolling Enabled" 1

feh --bg-scale $X_PATH/bg.jpg # Set wallpaper

xcompmgr & # alpha

# ibus-daemon -drx # ibus daemn for keyboard

xset r rate 200 45 # xset r rate [delay] [rate]

exec dwm
