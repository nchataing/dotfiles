xrdb .Xresources &
xfce4-clipman &
nm-applet &
dunst &
$HOME/.fehbg
eval $(gnome-keyring-daemon --start)
if ! ssh-add -l &>/dev/null; then
    eval $(ssh-agent -s)
fi
exec ,dwm
