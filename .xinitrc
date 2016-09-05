xscreensaver -nosplash&
xset fp+ ${HOME}/.fonts/
/usr/libexec/gnome-settings-daemon 1>/dev/null 2>/dev/null&
xmodmap -e "pointer = 1 2 3 4 5 6 7 8 9 10"
xrdb -merge .Xdefaults
~/bin/wallpaper.sh&
/usr/bin/urxvt256c-ml&
synergyc &
exec $WINDOWMANAGER
