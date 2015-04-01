#!/usr/bin/env bash

MIN_HEAP=${MIN_HEAP:=1G}
MAX_HEAP=${MAX_HEAP:=1G}
MANCENTER_ENABLED=${MANCENTER_ENABLED:=false}
MANCENTER_URL=${MANCENTER_URL:=http://mancenter:8080/mancenter/}
GROUP_NAME=${GROUP_NAME:=dev}
GROUP_PASS=${GROUP_PASS:=devpass}
PUBLIC_ADDRESS=${PUBLIC_ADDRESS:=`ip addr show eth0 | grep inet | grep -v inet6 | cut -d " " -f 6 | cut -d"/" -f1`}

java -Xms$MIN_HEAP -Xmx$MAX_HEAP -Dpublic.address=$PUBLIC_ADDRESS -Dgroup.name=$GROUP_NAME -Dgroup.pass=$GROUP_PASS -Dmancenter.enabled=$MANCENTER_ENABLED -Dmancenter.url=$MANCENTER_URL -Djava.net.preferIPv4Stack=true -Dhazelcast.config=/opt/hazelcast/hazelcast.xml -cp "/opt/hazelcast/lib/hazelcast.jar" com.hazelcast.core.server.StartServer

