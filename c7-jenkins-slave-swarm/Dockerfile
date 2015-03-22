FROM ansible/centos7-ansible:stable

# Add playbooks to the Docker image
ADD ansible /workspace
WORKDIR /workspace

# Run Ansible to configure the Docker image
RUN ansible-playbook jenkins_slave.yml -c local

ADD cmd.sh /cmd.sh

USER jenkins

VOLUME /var/lib/jenkins

CMD /bin/sh /cmd.sh
