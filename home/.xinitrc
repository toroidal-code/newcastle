#!/bin/sh
# Executed by startx (run your window manager from here)

xbindkeys
# Start important X stuff
xrdb -merge ~/.Xresources        #update X resources database
#xsetroot -cursor_name left_ptr & #show cursor over backgrounds
#echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches #behave, Dropbox!

# Fix Java GUIs
#export _JAVA_AWT_WM_NONREPARENTING=1

# Start a graphical session
# Examples: awesome, openbox-session, startxfce4, startlxde, gnome-session

#export GTK_IM_MODULE = uim
#export QT_IM_MODULE = uim
#uim-xim &
#export XMODIFIERS = @im = uim
#uim-toolbar-gtk3 &

#xmodmap ~/.Xmodmap

#export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

#session="awesome"
#exec $session > ~/.cache/wm_out 2> ~/.cache/wm_err
#exec gnome-session
#feh --bg-fill ~/Pictures/Wallpapers/wallpaper1.jpg
exec awesome
