#!/usr/bin/env sh

echo "exec shell here for the img build."

#add user, gsc
mkdir -p /data
useradd -m -d /data/www -s /bin/bash www

#gosuctl: root's permision for www
gsc add www #gosu 

#chpasswd: generate one when build
erpasswd root
erpasswd entry
erpasswd www

rm -f /build.sh