#!/bin/bash

sleep_time=${SLEEP_TIME:-15}
dig_options=${DIG_OPTIONS:-"+noall +answer"}
echo "Found DIG_TARGETS=${DIG_TARGETS}"

function get_me_out() {
  echo "Ctrl+c trapped, exiting because you asked"
  exit 0
}

trap get_me_out 2

if [ -z "${DIG_TARGETS}" ]; then
  echo "Doing nothing, DIG_TARGETS is not set"
  exit 1
fi

IFS=',' read -a targets <<< "${DIG_TARGETS}"

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
    echo "Digging [$target]"
    echo "dig start --------------------->"
    dig $target $dig_options
    echo "<--------------------- dig end"
    echo
  done
  echo "Sleeping ${sleep_time} seconds"
  echo
  sleep ${sleep_time}
done