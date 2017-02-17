#!/bin/bash
#
# Deal with defaults and overrides
#
sleep_time=${SLEEP_TIME:-15}
dig_options=${DIG_OPTIONS:-"+noall +answer"}
nc_options=${NC_OPTIONS:-"-v -w1 -i1"}
ping_options=${PING_OPTIONS:-"-c 1"}
do_dig=${DO_DIG:-1}
do_nc=${DO_NC:-1}
do_ping=${DO_PING:-1}
#
echo "Found NCDIG_TARGETS=${NCDIG_TARGETS}"
echo
echo "sleep_time [$sleep_time]"
echo "dig_options [$dig_options]"
echo "nc_options [$nc_options]"
echo "ping_options [$ping_options]"
echo "do_dig [$do_dig] do_nc [$do_nc] do_ping [$do_ping]"
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
    echo "Checking [$target/host=$host,port=$port]"
    if [ $do_dig == 1 ]; then
      echo "dig start --------------------->"
      dig $host $dig_options
      echo "<--------------------- dig end"
    fi
    if [ $do_nc == 1 ]; then
      echo "nc start --------------------->"
      nc $nc_options $host $port
      echo "<---------------------nc end"
    fi
    if [ $do_ping == 1 ]; then
      echo "ping start --------------------->"
      ping $ping_options $host
      echo "<--------------------- ping end"
    fi
    echo
  done
  echo "Sleeping ${sleep_time} seconds"
  echo
  sleep ${sleep_time}
done