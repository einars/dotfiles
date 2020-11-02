#!/bin/sh

time=$(date '+%a %-d. %b %-H:%M')
task=
stuff=

#if test -f /tmp/mpv.txt; then
#   stuff="$(cat /tmp/mpv.txt)  --  "
#fi

if test -f ~/.config/watson/state; then
  project=$(jq --raw-output .project ~/.config/watson/state)
  if test "null" != $project; then
    started=$(jq --raw-output .start ~/.config/watson/state)
    now_unix=$(date +%s)
    (( elapsed = ($now_unix - $started) / 60 ))
    task="$project ${elapsed}m  --  "
  else
    task="idle  --  "
  fi
fi


echo "$task$stuff$time"

