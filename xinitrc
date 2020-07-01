#!/bin/sh

desktop=openbox

run_system_scripts()
{
    if [ -d /etc/X11/xinit/xinitrc.d ] ; then                                                                                                                                                                          
        for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do                                                                                                                                                                      
            logger "Running $f"
            [ -x "$f" ] && . "$f"                                                                                                                                                                                            
        done                                                                                                                                                                                                              
        unset f                                                                                                                                                                                                           
    fi 
}

init_common()
{
    test -d /home/e/bin && export PATH=/home/e/bin:$PATH
    test -d /home/e/bin/private && export PATH=/home/e/bin/private:$PATH
    
    xsetroot -cursor_name left_ptr
    numlockx

    xrdb -merge /home/e/.Xresources

    # to hell with screensaver
    xset s off
    xset dpms 0 0 0

    xset r rate 300 30
}

init_morrigan()
{
    if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && type dbus-launch >/dev/null; then
        eval $(dbus-launch --sh-syntax --exit-with-session)
    fi
    # desktop=mate
}

init_sparta()
{
    logger "init_sparta"
    test -d /home/e/bin && export PATH=/home/e/bin:$PATH
    test -d /home/e/bin/private && export PATH=/home/e/bin/private:$PATH

    export QT_PLUGIN_PATH=/opt/lib32/usr/lib/qt/plugins
    # export WINEARCH=win32
    # export BROWSER=google-chrome
    export BROWSER=chromium

    # swap scrollwheel direction
    #xmodmap -e "pointer = 1 2 3 5 4"

    # set up latvian keymap and apple kbd customizations

    xcape -e 'Caps_Lock=Escape'

    # nvidia-settings --load-config-only

    # ~/bin/nv fast

    xset m 4 1 # mouse

    #eval $(dbus-launch --sh-syntax --exit-with-session 2>&1 | tee -a /tmp/dbus-launch.log)


    #start-pulseaudio-x11

}

init_common
init_$(uname -n)

run_system_scripts


ulimit -c unlimited

### if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && type dbus-launch >/dev/null; then
###   #eval $(dbus-launch --sh-syntax --exit-with-session 2>&1 | tee -a /tmp/dbus-launch.log)
###   eval $(dbus-launch --sh-syntax 2>&1 | tee -a /tmp/dbus-launch.log)
### fi
eval $(dbus-launch --sh-syntax 2>&1 | tee -a /tmp/dbus-launch.log)
exec ssh-agent /usr/bin/openbox --startup ~/.config/openbox/autostart 2>/tmp/x.$USER.stderr.log > /tmp/x.$USER.stdout.log
