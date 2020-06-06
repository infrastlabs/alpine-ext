#!/usr/bin/env bash
#echo $@

runDropbear #when $SSHD_ENABLE=true

#load env, ex: for env-java8:jvms-v1.0
source /etc/profile

# /bin/bash
exec $@ #trans exec
