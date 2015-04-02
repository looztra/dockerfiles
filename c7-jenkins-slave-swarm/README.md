What?
=====

* A docker container based on Centos (7), ready to run as a jenkins slave with java/maven/git/mercurial/docker.
* Auto discovers jenkins master (you need to install the swarm plugin and setup a login/password for the slave though)
* Fully compatible with the [jenkins official docker image](https://registry.hub.docker.com/_/jenkins/) 
* Built with Ansible.

Tools
=====

* openjdk6
* openjdk7
* openjdk8
* maven 3.0.5
* maven 3.1.1
* maven 3.2.5
* maven 3.3.1
* git
* mercurial
* nodejs + npm
* docker client

Credits
=======

* The ansible maven installation is adapted from the galaxy role [groover.maven](https://galaxy.ansible.com/list#/roles/458)
* The jenkins swarm client stuff is adapted from the [maestrodev build-agent](https://github.com/maestrodev/docker-images/blob/master/build-agent/)
