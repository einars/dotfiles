#!/bin/sh



watson_notify () {
  task="idle"
  task_style='task-idle'

  if test -f ~/.config/watson/state; then
    project=$(jq --raw-output .project ~/.config/watson/state)
    if test "null" != "$project"; then
      started=$(jq --raw-output .start ~/.config/watson/state)
      if test "null" != "$started"; then
        now_unix=$(date +%s)
        (( elapsed = ($now_unix - $started) / 60 ))
        (( elapsed_h = $elapsed / 60 ))
        (( elapsed_m = $elapsed % 60 ))
        #task="<span color=\"#33ff33\">$project ${elapsed}m  --  </span>"
        tags=$(jq --raw-output '.tags | join (", +")' ~/.config/watson/state)
        heart=$(printf '❤️%.0s' $(seq 1 $elapsed_h))
        if (( $elapsed_m >= 40 )); then
          heart="$heart❤️"
        elif (( $elapsed_m >= 20 )); then
          heart="$heart🤍"
        fi
        if [ "$elapsed_h" = "0" ]; then
          task=$(printf '%s %s +%s %dm' "$heart" "$project" "$tags" "$elapsed_m")
        else
          task=$(printf '%s %s +%s %dh %02dm' "$heart" "$project" "$tags" "$elapsed_h" "$elapsed_m")
        fi
        task_style='task-running'
      fi
    fi
  fi


  cat << EOF
    { "text": "  $task  ", "alt": "", "class": ["task", "$task_style"] }
EOF
}

mode=${1:-watch}

if [ "$mode" == "watch" ]; then
  pkill -f "WAYBAR_WATSON_TAG"
  watchexec --ignore WAYBAR_WATSON_TAG --postpone --restart --watch ~/.config/watson/ $0 notify &
  while true; do
    test -f ~/.config/watson/state && watson_notify
    sleep 10
  done

else
  watson_notify
fi
