#!/bin/bash

id=$(yabai -m query --spaces | jq '.[] | select(."has-focus" == false) | .index')
yabai -m window --space $id
