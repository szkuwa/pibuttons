#!/usr/bin/env bash

TMATE=/home/pi/tmate/tmate
SOCK=/tmp/tmate.sock

${TMATE} -S ${SOCK} new-session -d
${TMATE} -S ${SOCK} wait tmate-ready

${TMATE} -S ${SOCK} display -p '#{tmate_ssh}'
${TMATE} -S ${SOCK} display -p '#{tmate_ssh_ro}'
${TMATE} -S ${SOCK} display -p '#{tmate_web}'
${TMATE} -S ${SOCK} display -p '#{tmate_web_ro}'
