#!/usr/bin/env bash

chromium-browser --touch-events=enabled --disable-pinch --noerrdialogs --kiosk --app=$(head -n 1 /boot/fullpageos.txt) --ignore-certificate-errors
