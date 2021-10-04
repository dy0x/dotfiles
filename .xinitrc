#!/bin/sh

# merge with xinitrc.d, fix for some issues I had.
if [ -d /etc/X11/xinit/xinitrc.d ]; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# host based program startup
if [[ "$(cat /proc/sys/kernel/hostname)" == "somnia" ]]; then
	spotify &
#	dmigpumain &
#	flatpak run com.spotify.Client &
#	mpdscribble --conf "$HOME/.config/mpdscribble/mpdscribble.conf" &
elif [[ "$(cat /proc/sys/kernel/hostname)" == "wizone" ]]; then
	xrandr --output eDP1 --scale 1 --dpi 130
fi

# universal program startup
discord &
picom &
keepassxc &
nm-applet &
dwmblocks &
sxhkd &
blueberry-tray &
rclone --vfs-cache-mode writes mount "uni onedrive": /home/dylan/onedrive &
#nabi &
#nordvpn c Australia Sydney &
xss-lock --transfer-sleep-lock -- betterlockscreen -l blur --display 1 &
#flatpak run com.discordapp.Discord --start-minimized --disable-seccomp-filter-sandbox &
#flatpak run com.discordapp.Discord --start-minimized &

# Fcitx
#fcitx &
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

#wal -R
~/.fehbg &
[[ -f ~/.config/Xresources ]] && xrdb -merge ~/.config/Xresources

while true; do
    #dwm 2> ~/.cache/dwm.log
    dwm >/dev/null 2>&1
done
