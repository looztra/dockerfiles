What?
=====

Hazelcast in tcp discovery mode

Environment Variables
=====================

`MIN_HEAP`: This variable is to set the initial mem of the java HEAP. (Default: 1G)

`MAX_HEAP`: This variable is to set the maximum mem of the java HEAP. (Default: 1G)

`GROUP_NAME`: This is to set the group name for the hazelcast cluster. (Default: dev)

`GROUP_PASS`: This variable sets the password for the group of the hazelcast cluster. (Default: devpass)

`MANCENTER_ENABLED`: defaults to false

`MANCENTER_URL`: defaults to http://mancenter:8080/mancenter, override if needed

`CLUSTER_MEMBERS`: comma separated list of cluster members (same format as the hazelcast expects i.e. host or host:port). Typically used with docker links.


How to run
==========

This docker image has service discovery enabled on port 5701 without port auto increment

	docker run --rm --name hazelcast1 -p 5701:5701 -e "MIN_HEAP=256M" -e "MAX_HEAP=256M" -e "GROUP_NAME=test" -e "GROUP_PASS=test_pass" looztra/deb-hazelcast


Credits
=======
inspired by

* [cacciald/hazelcast](https://registry.hub.docker.com/u/cacciald/hazelcast/)
* [hazelcast/hazelcast](https://registry.hub.docker.com/u/hazelcast/hazelcast/)
* [jarias/hazelcast](https://registry.hub.docker.com/u/jarias/hazelcast/)
