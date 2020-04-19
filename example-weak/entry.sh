#!/usr/bin/env bash
#echo $@

runDropbear #when $SSHD_ENABLE=true

# /bin/bash
exec $@ #trans exec
