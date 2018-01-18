#!/bin/bash

gcc -Wall -o buttons buttons.c -lwiringPi

URL=$(cat /boot/fullpageos.txt)
if [[ $URL == *"#"* ]]; then
    MAC=""
else
    MAC=$(cat /sys/class/net/eth0/address)
    MAC="#${MAC//:/}"
fi
echo "url = '$URL$MAC';" > web/url.js

git log \
    --pretty=format:'{%n  "commit": "%H",%n  "commit_short": "%h",%n  "author": "%aN <%aE>",%n  "date": "%ad",%n  "message": "%f"%n},' \
    $@ | \
    perl -pe 'BEGIN{print "var commits = ["}; END{print "]\n"}' | \
    perl -pe 's/},]/}]/' > web/commits.js

if [ ! -f /home/pi/.ssh/id_rsa ]; then
    ssh-keygen -f /home/pi/.ssh/id_rsa -t rsa -N ''
    chown pi:pi /home/pi/.ssh/id_rsa
fi

if [ -f /home/pi/pibuttons/enable_tmate ]; then
    cp /home/pi/pibuttons/install/tmate.conf /home/pi/.tmate.conf
    ID=$(echo "${URL}${MAC}" | sed -e 's/.*#//g')
    echo "set-option -g tmate-webhook-url \"${URL/optometrist-display/tmate}${MAC}\"" >> /home/pi/.tmate.conf
    USERDATA="${ID}"
    echo "set-option -g tmate-webhook-userdata \"${USERDATA}\"" >> /home/pi/.tmate.conf
fi
