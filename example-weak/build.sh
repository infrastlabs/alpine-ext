#!/usr/bin/env sh

#install debug tools
#bind-tools: dig
apk add openssh-client bind-tools

#chpasswd: generate one when build
epasswd root root
epasswd entry entry

#dropbear
# Install
apk add dropbear openssh-sftp-server
apk add python #jumpserver get listInfo need python
mkdir /etc/dropbear
echo 'Cmnd_Alias SU = /bin/su' >> /etc/sudoers

#ctapp, ctoper
useradd -m -d /home/ctapp  -s /bin/bash -u 665 ctapp #665
epasswd ctapp ctapp
useradd -m -d /home/ctoper -s /bin/bash -u 666 ctoper
epasswd ctoper ctoper

rm -f /build.sh