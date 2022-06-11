#!/bin/bash

kitty_id=$(yabai -m query --windows | jq -re '.[] | select(."app" == "kitty") | .id')
qute_id=$(yabai -m query --windows | jq -re '.[] | select(."app" == "qutebrowser") | .id')

if [[ $kitty_id && $qute_id ]]; then
  # Move others to secondary
  s1=$(yabai -m query --windows --space 1 | jq -re '.[] | .id')
  for w in $s1
  do
    if [ "$w" != "$kitty_id" ] && [ "$w" != "$qute_id" ]; then
      yabai -m window $w --space 2
    fi
  done
  # Make sure kitty and qutebrowser in primary
  yabai -m window $kitty_id --space 1
  yabai -m window $qute_id --space 1
  yabai -m config --space 1 layout bsp
  yabai -m window $kitty_id --swap east
fi
