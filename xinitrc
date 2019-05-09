#!/bin/sh

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
    test -d $HOME/bin && export PATH=$HOME/bin:$PATH
    test -d $HOME/bin/private && export PATH=$HOME/bin/private:$PATH
    
    xsetroot -cursor_name left_ptr
    numlockx

    xrdb -merge $HOME/.Xresources

    # to hell with screensaver
    xset s off
    xset dpms 0 0 0

    xset r rate 300 30
}

init_morrigan()
{
  true
}

init_sparta()
{
    export BROWSER=firefox
    xset m 4 1 # mouse
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

exec ssh-agent /usr/bin/openbox --startup ~/.config/openbox/autostart
