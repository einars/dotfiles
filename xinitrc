#!/usr/bin/env zsh

function setup_apple_keyboard()
{
echo '
keycode 94 = grave asciitilde grave asciitilde asciitilde
remove mod4 = Super_R
keycode 134 = ISO_Level3_Shift' | xmodmap -
}

function init_common()
{
    export PATH=$HOME/bin:$HOME/bin/private:$PATH
    export WINEDLLOVERRIDES=winemenubuilder.exe=d
    export GVFS_DISABLE_FUSE=1
    export SDL_AUDIODRIVER=alsa
    export _JAVA_OPTIONS='-Dawd.useSystemAAFontSettings=on -Dswing.aatext=true'

    setxkbmap lv -option -option ctrl:nocaps

    xsetroot -cursor_name left_ptr
    numlockx

    xrdb -merge ~/.Xresources

    xset s off
    xset dpms 0 0 0

}



function init_sparta()
{
    export QT_PLUGIN_PATH=/opt/lib32/usr/lib/qt/plugins
    export WINEARCH=win32
    export BROWSER=google-chrome

    # swap scrollwheel direction
    #xmodmap -e "pointer = 1 2 3 5 4"

    setxkbmap lv -option -option ctrl:nocaps  -option altwin:swap_lalt_lwin
    setup_apple_keyboard

    nvidia-settings --load-config-only

    # leisure user
    #if [[ $USER = e ]]; then
        #export desktop_wm=xfce
    #fi

    # work user
    if [[ $USER = e ]]; then
        export desktop_wm=openbox
    fi

}



init_common
init_$(uname -n)


if [[ $desktop_wm == "xmonad" ]]; then

    export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
    export _JAVA_AWT_WM_NONREPARENTING=1

    export PATH=$HOME/.xmonad/bin:$PATH

    hsetroot -solid '#111111'

    trayer --edge top --align right --transparent true --SetDockType true --SetPartialStrut true --width 16 --height 11 --transparent true --tint 0x000000 &

    parcellite &
    skype &
    ( sleep 2s && pidgin ) &
    ( sleep 4s && opera ) &

    exec ck-launch-session xmonad
fi

if [[ $desktop_wm == "awesome" ]]; then
    hsetroot -solid '#111111'
    exec awesome
fi


if [[ $desktop_wm == "xfce" ]]; then
    exec startxfce4
fi

if [[ $desktop_wm == "openbox" ]]; then
    #exec ck-launch-session dbus-launch openbox-session-debug
    #exec openbox-session-ulimit
    #exec ssh-agent /opt/openbox/bin/openbox-session
    ulimit -c unlimited
    exec ssh-agent /usr/bin/openbox --startup ~/.config/openbox/autostart

fi

#exec ck-launch-session openbox
