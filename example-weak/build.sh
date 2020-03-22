#!/usr/bin/env sh

echo "exec shell here for the img build."

#install debug tools
#bind-tools: dig
apk add openssh bind-tools

#chpasswd: generate one when build
epasswd root root
epasswd entry entry

rm -f /build.sh