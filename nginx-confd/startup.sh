#!/bin/ash

if /usr/local/bin/confd -onetime -backend env
  then
    echo
    echo "w00t w00t!! config has been generated, let's start nginx now"
    nginx -g 'daemon off;'
 else
    echo "You failed at starting confd and/or nginx properly"
fi