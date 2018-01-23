#!/usr/bin/env bash

git pull origin master
./build.sh

if [ -f /home/pi/pibuttons/enable_tmate ]; then
    ./tmate.sh &
fi

# ./run.sh
