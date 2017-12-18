#!/bin/sh

run_system_scripts()
{
    if [ -d /etc/X11/xinit/xinitrc.d ] ; then                                                                                                                                                                          
        for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do                                                                                                                                                                      
            [ -x "$f" ] && . "$f"                                                                                                                                                                                            
        done                                                                                                                                                                                                              
        unset f                                                                                                                                                                                                           
    fi 
}

init_common()
{
    test -d ~/bin && export PATH=~/bin:$PATH
    test -d ~/bin/private && export PATH=~/bin/private:$PATH
    test -d ~/.opam/system/bin && export PATH=~/.opam/system/bin:$PATH
    
    export STEAM_FRAME_FORCE_CLOSE=1

    #setxkbmap lv -option ctrl:nocaps

    xsetroot -cursor_name left_ptr
    numlockx

    xrdb -merge ~/.Xresources

    # to hell with screensaver
    xset s off
    xset dpms 0 0 0

}



init_sparta()
{
    test -d /home/e/bin && export PATH=/home/e/bin:$PATH
    test -d /home/e/bin/private && export PATH=/home/e/bin/private:$PATH

    export QT_PLUGIN_PATH=/opt/lib32/usr/lib/qt/plugins
    # export WINEARCH=win32
    export BROWSER=google-chrome

    # swap scrollwheel direction
    #xmodmap -e "pointer = 1 2 3 5 4"

    # set up latvian keymap and apple kbd customizations
    rekey

    # nvidia-settings --load-config-only

    # ~/bin/nv fast

    xset m 4 1 # mouse

    if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && type dbus-launch >/dev/null; then
        eval $(dbus-launch --sh-syntax --exit-with-session)
    fi

    #start-pulseaudio-x11

}

init_common
init_$(uname -n)

run_system_scripts


ulimit -c unlimited
exec ssh-agent /usr/bin/openbox --startup ~/.config/openbox/autostart
# exec ssh-agent /usr/bin/openbox-session
