#!/bin/sh

echo '{ "version": 1 }'
echo '['


while true; do

  time=$(date '+%a %-d. %b %-H:%M')
  task="idle"
  task_style='"color": "#777777"'

  if test -f ~/.config/watson/state; then
    project=$(jq --raw-output .project ~/.config/watson/state)
    if test "null" != $project; then
      started=$(jq --raw-output .start ~/.config/watson/state)
      now_unix=$(date +%s)
      (( elapsed = ($now_unix - $started) / 60 ))
      #task="<span color=\"#33ff33\">$project ${elapsed}m  --  </span>"
      tags=$(jq --raw-output '.tags | join (", +")' ~/.config/watson/state)
      task="$project +$tags ${elapsed}m"
      task_style='"color": "#33ee33"'
    fi
  fi


  cat << EOF
  [
    { "name": "id_task", "full_text": "  $task  ", $task_style },
    { "name": "id_date", "full_text": "  $time  " }
  ],
EOF

  sleep 5

done
