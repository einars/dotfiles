#!/bin/bash

# Get regular windows
regular_windows=$(swaymsg -t get_tree | jq -r '.nodes[1].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ."  )

# Get floating windows
floating_windows=$(swaymsg -t get_tree | jq '.nodes[1].nodes[].floating_nodes[] | (.id|tostring) + " " + .name?'| grep -e "[0-9]* ." | tr -d '"')

enter=$'\n'
if [[ $regular_windows && $floating_windows ]]; then
  all_windows="$regular_windows$enter$floating_windows"
elif [[ $regular_windows ]]; then
  all_windows=$regular_windows
else
  all_windows=$floating_windows
fi


lines=$(echo "$all_windows" | wc -l)
selected=$(echo "$all_windows" | rofi -lines $lines -hide-scrollbar -width -80 -dmenu -i | awk '{print $1}')
swaymsg [con_id="$selected"] focus
