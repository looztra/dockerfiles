#!/bin/bash

sleep_time=${SLEEP_TIME:-15}
dig_options=${DIG_OPTIONS:-"+noall +answer"}
nc_option=${NC:-"-v -w1 -i1"}
echo "Found NCDIG_TARGETS=${NCDIG_TARGETS}"

function get_me_out() {
  echo "Ctrl+c trapped, exiting because you asked"
  exit 0
}

trap get_me_out 2

if [ -z "${NCDIG_TARGETS}" ]; then
  echo "Doing nothing, NCDIG_TARGETS is not set"
  exit 1
fi

IFS=',' read -a targets <<< "${NCDIG_TARGETS}"

for target in "${targets[@]}"
do
   echo "found target [$target]"
done

echo "Let's start testing targets!"
echo "============================>"
echo

while true; do
  date
  echo
  for target in "${targets[@]}"
  do
    host=$(echo ${target} | cut -d":" -f1)
    port=$(echo ${target} | cut -d":" -f2)
    echo "Digging and NCing [$target/host=$host,port=$port]"
    echo "dig start --------------------->"
    dig $host $dig_options
    echo "<--------------------- dig end"
    echo "nc start --------------------->"
    nc $nc_option $host $port
    echo "<---------------------nc end"
    echo
  done
  echo "Sleeping ${sleep_time} seconds"
  echo
  sleep ${sleep_time}
done