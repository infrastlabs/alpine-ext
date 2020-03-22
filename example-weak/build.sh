#!/usr/bin/env sh

echo "exec shell here for the img build."

#install debug tools
apk add openssh

#chpasswd: generate one when build
epasswd root root
epasswd entry entry

rm -f /build.sh