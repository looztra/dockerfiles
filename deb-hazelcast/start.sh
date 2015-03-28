#!/usr/bin/env bash

MIN_HEAP=${MIN_HEAP:=1G}
MAX_HEAP=${MAX_HEAP:=1G}
GROUP_NAME=${GROUP_NAME=dev}
GROUP_PASS=${GROUP_PASS=devpass}

sed -i "s/GROUP_NAME/$GROUP_NAME/;s/GROUP_PASS/$GROUP_PASS/" /opt/hazelcast/hazelcast.xml

java -Xms$MIN_HEAP -Xmx$MAX_HEAP -Djava.net.preferIPv4Stack=true -Dhazelcast.config=/opt/hazelcast/hazelcast.xml -cp "/opt/hazelcast/lib/hazelcast.jar" com.hazelcast.core.server.StartServer

