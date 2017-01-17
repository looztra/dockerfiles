#!/bin/bash

sleep_time=${SLEEP_TIME:-15}
echo "Found NETCAT_TARGETS=${NETCAT_TARGETS}"

function get_me_out() {
  echo "Ctrl+c trapped, exiting because you asked"
  exit 0
}

trap get_me_out 2

if [ -z "${NETCAT_TARGETS}" ]; then
  echo "Doing nothing, NETCAT_TARGETS is not set"
  exit 1
fi

IFS=',' read -a targets <<< "${NETCAT_TARGETS}"

for target in "${targets[@]}"
do
   echo "found target [$target]"
done

echo "Let's start testing targets!"

while true; do
  date
  for target in "${targets[@]}"
  do
    host=$(echo ${target} | cut -d":" -f1)
    port=$(echo ${target} | cut -d":" -f2)
    echo "testing [$target]"
    nc -v -w1 -i1 $host $port
  done
  echo "Sleeping ${sleep_time} seconds"
  echo
  sleep ${sleep_time}
done