#!/usr/bin/env bash

rm -rf /home/pi/.cache/chromium/Default/Cache
rm -rf /home/pi/.config/chromium/Default

chromium-browser --touch-events=enabled --disable-pinch --noerrdialogs --kiosk --app=file:///home/pi/pibuttons/web/index.html --ignore-certificate-errors
