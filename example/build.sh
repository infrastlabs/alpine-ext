#!/usr/bin/env sh

echo "exec sht here for build the img."

#add user, gsc
mkdir -p /data
useradd -m -d /data/www -s /bin/bash www
gsc add www #gosu root's permision for entry

#chpasswd: generate one when build
erpasswd root
erpasswd entry
erpasswd www

rm -f /build.sh