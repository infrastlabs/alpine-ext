#!/usr/bin/env bash
#echo $@

#dropbear
if [ "$SSHD_ENABLE" = "true" ]; then
  dropbear -E -F -R -p 22 
fi
