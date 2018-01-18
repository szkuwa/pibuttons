#!/usr/bin/env bash

/usr/bin/fbi -d /dev/fb0 --noverbose $(head -n 1 /boot/logo.txt)
