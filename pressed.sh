#!/usr/bin/env bash

echo "Short press"

export DISPLAY=:0
WID=$(xdotool search --onlyvisible --class chromium|head -1)
xdotool windowactivate ${WID}
xdotool key p
