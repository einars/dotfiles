#!/bin/sh

show_coffee () {
  icon_style='task-idle'
  if test -s /etc/dnscrypt-proxy/whitelist.txt; then
    icon_style='task-running'
  fi

  text='☕'

  cat << EOF
    { "text": "  $text  ", "alt": "", "class": ["task", "$icon_style"] }
EOF
}



mode=${1:-watch}

if [ "$mode" == "watch" ]; then

  pkill -f "WAYBAR_COFFEE_TAG"
  watchexec --verbose --ignore WAYBAR_COFFEE_TAG --postpone --restart --watch /etc/dnscrypt-proxy/ "$0" notify &

  while true; do
    show_coffee
    sleep 10
  done
else
  show_coffee
fi
