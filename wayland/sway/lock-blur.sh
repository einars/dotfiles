#!/bin/bash
trap cleanup 0 1 2 3 6

image="/tmp/lock_sway_image-$$.png"
width=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .current_mode.width')

function cleanup {
  rm ${image}
}


# Generate screenshot of currently focused monitor
grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') ${image}

# and then blur
gm convert ${image} -scale 25% -blur 0x3 -scale 400% -fill black -colorize 10% ${image}

[[ -f $1 ]] && convert ${image} $1 \
                  -gravity center   \
                  -composite        \
                  -matte ${image}

gm convert ${image} ${text} -gravity center -geometry +0+200 -composite ${image}
swaylock -s fill -i ${image}
