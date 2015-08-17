FROM ansible/centos7-ansible:stable

# Add playbooks to the Docker image
ADD ansible /workspace
WORKDIR /workspace

# Run Ansible to configure the Docker image
RUN ansible-playbook docker_client.yml -c local

CMD ["bash"]