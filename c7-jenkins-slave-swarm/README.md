What?
=====

* A docker container based on Centos (7), ready to run as a jenkins slave with java/maven/git/mercurial.
* Auto discovers jenkins master.
* Fully compatible with the [jenkins official docker image](https://registry.hub.docker.com/_/jenkins/) or [my own customized one](https://registry.hub.docker.com/u/looztra/jenkins-1.580.1/) that is an up to date (latest LTS is 1.580.1) with a fixed uid for the jenkins user (1102, usefull to mount local volumes without giving a chmod 777)
* Built with Ansible.

Credits
=======

* The ansible maven installation is adapted from the galaxy role [groover.maven](https://galaxy.ansible.com/list#/roles/458)
* The jenkins swarm client stuff is adapted from the [maestrodev build-agent](https://github.com/maestrodev/docker-images/blob/master/build-agent/)
