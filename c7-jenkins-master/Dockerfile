FROM ansible/centos7-ansible:stable

# Add playbooks to the Docker image
ADD ansible /workspace
WORKDIR /workspace

# Run Ansible to configure the Docker image
RUN ansible-playbook jenkins_master.yml -c local

#ADD cmd.sh /cmd.sh

#CMD /bin/sh /cmd.sh

VOLUME /var/jenkins_home


ENV JENKINS_UC https://updates.jenkins-ci.org

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

USER jenkins

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
