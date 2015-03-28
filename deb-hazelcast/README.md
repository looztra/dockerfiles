What?
=====

Hazelcast in tcp discovery mode

Environment Variables
=====================

`MIN_HEAP`: This variable is to set the initial mem of the java HEAP. (Default: 1G)

`MAX_HEAP`: This variable is to set the maximum mem of the java HEAP. (Default: 1G)

`GROUP_NAME`: This is to set the group name for the hazelcast cluster. (Default: dev)

`GROUP_PASS`: This variable sets the password for the group of the hazelcast cluster. (Default: devpass)

How to run
==========

This docker image has service discovery enabled on port 5701 without port auto increment

	docker run --rm=true --name hazelcast1 -p 5701:5701 -e "MIN_HEAP=256M" -e "MAX_HEAP=256M" -e "GROUP_NAME=test" -e "GROUP_PASS=test_pass" looztra/deb-hazelcast


Credits
=======
inspired by

* https://registry.hub.docker.com/u/cacciald/hazelcast/
* https://registry.hub.docker.com/u/hazelcast/hazelcast/
