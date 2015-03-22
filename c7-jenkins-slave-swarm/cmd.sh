#!/bin/sh

SWARM_JAR=${SWARM_JAR:-/opt/jenkins_swarm_client/swarm-client-jar-with-dependencies.jar}
SWARM_JAVA_BINARY=${SWARM_JAVA_BINARY:-/usr/lib/jvm/java-1.7.0/bin/java}
SWARM_NB_EXECUTORS=${SWARM_NB_EXECUTORS:-4}
SWARM_EXPORTED_VOLUME=${SWARM_EXPORTED_VOLUME:-/var/lib/jenkins}

PARAMS=""
if [ ! -z "$JENKINS_USERNAME" ]; then
  PARAMS="$PARAMS -username $JENKINS_USERNAME"
fi
if [ ! -z "$JENKINS_PASSWORD" ]; then
  PARAMS="$PARAMS -password $JENKINS_PASSWORD"
fi
if [ ! -z "$JENKINS_MASTER" ]; then
  PARAMS="$PARAMS -master $JENKINS_MASTER"
fi
if [ ! -z "$SLAVE_DESCRIPTION" ]; then
  PARAMS="$PARAMS -description $SLAVE_DESCRIPTION"
fi

#
# we do that only now because we need the volume to be mounted before doing that :)
#
mkdir -p ${SWARM_EXPORTED_VOLUME}/jenkins
mkdir -p ${SWARM_EXPORTED_VOLUME}/dot_jenkins
mkdir -p ${SWARM_EXPORTED_VOLUME}/dot_maven
#
cd /home/jenkins
ln -s ${SWARM_EXPORTED_VOLUME}/dot_jenkins .jenkins
#
ln -s ${SWARM_EXPORTED_VOLUME}/dot_maven .m2
#
cd /home/jenkins
java -jar ${SWARM_JAR} ${PARAMS} -fsroot ${SWARM_EXPORTED_VOLUME}/jenkins -executors ${SWARM_NB_EXECUTORS}
